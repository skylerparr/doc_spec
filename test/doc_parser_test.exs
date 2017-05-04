defmodule DocParserTest do
  use ExUnit.Case, async: true
  require IEx

  test "extract topics from string" do 
    string = """
    Test:
    blah blah
    other sorts of blah

    Bar:
    more blahlaut
    """

    parsed = DocParser.parse(string)
    assert parsed == [test: ["blah blah", "other sorts of blah"], bar: ["more blahlaut"]]
  end

  test "groups keys by special topic" do
   string = 
    """
    Description:
    blah blah

    Group:
    Something about the group
    I like this group also

    Bar:
    more blahlaut

    Foo:
    some Foo

    Group:
    Something about this groups

    Bar:
    Group2
    and some Bar
    don't forget the nachos

    Foo:
    Group2
    """

    parsed = DocParser.parse(string)
    assert parsed == [description: ["blah blah"],
     group: ["Something about the group", "I like this group also"],
     bar: ["more blahlaut"],
     foo: ["some Foo"], 
     group: ["Something about this groups"],
     bar: ["Group2", "and some Bar", "don't forget the nachos"],
     foo: ["Group2"]]
  end
end
