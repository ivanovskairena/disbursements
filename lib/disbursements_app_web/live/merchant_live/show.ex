defmodule DisbursementsAppWeb.MerchantLive.Show do
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
     |> assign(:merchant, Disb.get_merchant!(id))}
  end

  defp page_title(:show), do: "Show Merchant"
  defp page_title(:edit), do: "Edit Merchant"
end
