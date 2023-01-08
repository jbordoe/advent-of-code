defmodule Aoc20.Day4.Test do
  use ExUnit.Case
  doctest Aoc20.Day4
  alias Aoc20.Day4

  @fixture "test/fixtures/2020/day_4/part_1.txt"

  test "#solution1 gets the right answer" do
    assert 2 == Day4.solution1(input())
  end

  describe "#valid -" do
    test "invalid pid" do
      input =
        to_stream("""
        eyr:1972 cid:100
        hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926
        """)

      assert false == Day4.valid?(input)
    end

    test "invalid eyr" do
      input =
        to_stream("""
        iyr:2019
        hcl:#602927 eyr:1967 hgt:170cm
        ecl:grn pid:012533040 byr:1946
        """)

      assert false == Day4.valid?(input)
    end

    test "invalid hcl" do
      input =
        to_stream("""
        hcl:dab227 iyr:2012
        ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277
        """)

      assert false == Day4.valid?(input)
    end

    test "invalid ecl" do
      input =
        to_stream("""
        hgt:59cm ecl:zzz
        eyr:2038 hcl:74454a iyr:2023
        pid:3556412378 byr:2007
        """)

      assert false == Day4.valid?(input)
    end

    test "valid 1" do
      input =
        to_stream("""
        pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
        hcl:#623a2f
        """)

      assert true == Day4.valid?(input)
    end

    test "valid 2" do
      input =
        to_stream("""
        eyr:2029 ecl:blu cid:129 byr:1989
        iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm
        """)

      assert true == Day4.valid?(input)
    end

    test "valid 3" do
      input =
        to_stream("""
        hcl:#888785
        hgt:164cm byr:2001 iyr:2015 cid:88
        pid:545766238 ecl:hzl
        eyr:2022
        """)

      assert true == Day4.valid?(input)
    end

    test "valid 4" do
      input =
        to_stream("""
        iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719
        """)

      assert true == Day4.valid?(input)
    end
  end

  defp input(), do: Helper.stream_lines_from_file(@fixture)
  defp to_stream(str), do: String.split(str, "\n") |> Stream.concat([])
end
