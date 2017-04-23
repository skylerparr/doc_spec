defmodule TestAttributes do
  use DocSpec

  @docspec """
  When invoked it returns id when given no user

  Given:
  user = %{id: 100}

  Example:
  iex> TestAttributes.my_func(user)
  100
  """
  def my_func(arg) do
    #IO.inspect @docspec
    arg.id
  end

  @docspec """
  Will return a string

  Example:
  iex> TestAttributes.get_string
  "foo"
  """
  def get_string do
    "foo"
  end
end
