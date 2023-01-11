defmodule DisbursementsAppWeb.MerchantLive.Index do
  use DisbursementsAppWeb, :live_view

  alias DisbursementsApp.Disb
  alias DisbursementsApp.Disb.Merchant

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :merchants, list_merchants())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Merchant")
    |> assign(:merchant, Disb.get_merchant!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Merchant")
    |> assign(:merchant, %Merchant{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Merchants")
    |> assign(:merchant, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    merchant = Disb.get_merchant!(id)
    {:ok, _} = Disb.delete_merchant(merchant)

    {:noreply, assign(socket, :merchants, list_merchants())}
  end

  defp list_merchants do
    Disb.list_merchants()
  end
end
