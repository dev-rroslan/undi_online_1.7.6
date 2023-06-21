defmodule UndiOnlineWeb.WrongLive do
  use UndiOnlineWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        message: "Guess a number",
        score: 0,
        answer: nil
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <.link href="#" phx-click="guess" phx-value-number={n}>
          <%= n %>
        </.link>
      <% end %>
    </h2>
    """
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    answer = socket.assigns.answer
    guess = String.to_integer(guess)

    is_correct = if answer == guess, do: true, else: false

    if is_correct do
      message = "Your guess: #{guess}. Correct. Guess again. "
      score = socket.assigns.score + 10

      {
        :noreply,
        assign(
          socket,
          message: message,
          score: score,
          answer: rand()
        )
      }
    else
      message = "Your guess: #{guess}. Wrong."
      score = socket.assigns.score - 1

      {
        :noreply,
        assign(
          socket,
          message: message,
          score: score,
          answer: rand()
        )
      }
    end
  end

  defp rand do
    Enum.random(1..10)
  end
end
