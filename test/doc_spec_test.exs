defmodule DocSpecTest do
  use ExUnit.Case
  doctest DocSpec

  alias Sample.TestAttributes

  test "the truth" do
    assert 1 + 1 == 2
  end

  #  test "get the @value" do
  #  TestAttributes.my_func(%{id: 100})
  #end
end
