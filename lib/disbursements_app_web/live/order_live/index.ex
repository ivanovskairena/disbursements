defmodule DisbursementsAppWeb.OrderLive.Index do
  use DisbursementsAppWeb, :live_view

  alias DisbursementsApp.Disb
  alias DisbursementsApp.Disb.Order

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :orders, list_orders())}
  end
  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Order")
    |> assign(:order, Disb.get_order!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Order")
    |> assign(:order, %Order{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Orders")
    |> assign(:order, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    order = Disb.get_order!(id)
    {:ok, _} = Disb.delete_order(order)

    {:noreply, assign(socket, :orders, list_orders())}
  end

  defp list_orders do
    Disb.list_orders()
  end
end
