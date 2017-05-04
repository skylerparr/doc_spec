defmodule Sample.TestAttributes do
  use DocSpec

  @docspec """
  Description:
  Does special things to a user
  
  Case:
  When invoked it returns id when given a user

  Given:
  user = %{id: 100}

  Example:
  iex> TestAttributes.my_func(user)
  100
  """
  def my_func(arg) do
    IO.inspect arg
    arg.id
  end

  @docspec """
  Case:
  Will return a string

  Example:
  iex> TestAttributes.get_string("foo")
  "foo"

  iex> TestAttributes.get_string("bar")
  "bar"
  """
  def get_string(s) do
    s
  end
end
