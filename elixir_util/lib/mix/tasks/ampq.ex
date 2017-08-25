defmodule Mix.Tasks.Ampq do
  use Mix.Task
  @username "admin@admin.com"
  @password "password123"

  defmodule Consumer do
    use GenServer

    def start_link(un, pw) do
      GenServer.start_link(__MODULE__, [un, pw], name: __MODULE__)
    end

    def publish(payload) do
      GenServer.call(__MODULE__, {:publish, payload})
    end

    def init([un, pw]) do
      payload = %{
        user: %{email: un, password: pw}
      } |> Poison.encode!

      request = {'http://localhost:3000/api/tokens', [], 'application/json', payload |> to_charlist()}
      {:ok, {_, _, resp}} = :httpc.request(:post, request, [], [])
      %{"token" => %{"encoded" => tkn}} = Poison.decode!(resp)

      IO.puts "Connect."
      {:ok, connection} = AMQP.Connection.open(host: "localhost", username: un, password: tkn)

      # {:ok, connection} = AMQP.Connection.open()
      IO.puts "Create a channel."
      {:ok, channel}    = AMQP.Channel.open(connection)

      IO.puts "Create a queue so that you have something to publish messages to."
      AMQP.Queue.declare(channel, "hello")

      AMQP.Basic.consume(channel, "hello", self(), no_ack: true)
      {:ok, %{connection: connection, channel:  channel}}
    end

    def handle_info({:basic_deliver, payload, _meta}, state) do
      IO.puts "Got payload!: #{payload} \r\n"
      {:noreply, state}
    end

    def handle_info(_, state) do
      {:noreply, state}
    end

    def handle_call({:publish, payload}, _, state) do
      r = AMQP.Basic.publish(state.channel, "", "hello", payload)
      {:reply, r, state}
    end


    def terminate(_, state) do
      IO.puts "Closing up shop."
      AMQP.Connection.close(state.connection)
    end
  end

  def run(_) do
    :inets.start()
    {:ok, _} = Consumer.start_link(@username, @password)
  end
end
