defmodule Rocketpay.Numbers do
  # Se usarmos o alias Rocketpay.Number, podemos chamar o método
  # sum_from_file atrvés de alias Numbers.sum_from_file
  # Se usarmos alias Numbers.sum_from_file, as: Banana
  # poderiamos fazer: Banana.sum_from_file
  def sum_from_file(filename) do
    "#{filename}.csv"
    |> File.read()
    |> handle_file()
  end

  defp handle_file({:ok, result}) do
    result =
      result
      |> String.split(",")
      |> Enum.map(fn number -> String.to_integer(number) end)
      |> Enum.sum()
      {:ok, %{result: result}}
  end
  defp handle_file({:error, _reason}), do: {:error, "Invalid File"}
end
