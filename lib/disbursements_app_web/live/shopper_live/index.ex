defmodule DisbursementsAppWeb.ShopperLive.Index do
  use DisbursementsAppWeb, :live_view

  alias DisbursementsApp.Disb
  alias DisbursementsApp.Disb.Shopper

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :shoppers, list_shoppers())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Shopper")
    |> assign(:shopper, Disb.get_shopper!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Shopper")
    |> assign(:shopper, %Shopper{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Shoppers")
    |> assign(:shopper, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    shopper = Disb.get_shopper!(id)
    {:ok, _} = Disb.delete_shopper(shopper)

    {:noreply, assign(socket, :shoppers, list_shoppers())}
  end

  defp list_shoppers do
    Disb.list_shoppers()
  end
end
