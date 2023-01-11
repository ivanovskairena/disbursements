defmodule DisbursementsAppWeb.ShopperLive.Show do
  use DisbursementsAppWeb, :live_view

  alias DisbursementsApp.Disb

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:shopper, Disb.get_shopper!(id))}
  end

  defp page_title(:show), do: "Show Shopper"
  defp page_title(:edit), do: "Edit Shopper"
end
