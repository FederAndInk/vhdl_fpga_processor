library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity ALU is
  port (
    E : in std_logic;
    a : in std_logic_vector(15 downto 0);
    b : in std_logic_vector(15 downto 0);
    op : in std_logic_vector(3 downto 0);
    dst : out std_logic_vector(15 downto 0);
    clk : in std_logic
  );
end ALU;

architecture arch of ALU is
  component random is
    port (
      E : in std_logic;
      R : out std_logic_vector(15 downto 0);
      rst : in std_logic;
      clk : in std_logic
    );
  end component;

  signal rand : std_logic_vector(15 downto 0);
  signal E_rand : std_logic;
begin
  E_rand <= '1' when E = '1' and op = "1011" else '0';
  random_inst : random
  port map(
    E => E_rand,
    R => rand,
    rst => '0',
    clk => clk
  );

  funit : process (a, b, op, E)
  begin
    case op is
      when "0000" =>
        dst <= a - b - 1;
      when "0001" =>
        dst <= a + b;
      when "0010" =>
        dst <= a - b;
      when "0011" =>
        dst <= a + b + 1;
      when "0100" =>
        dst <= not a;
      when "0101" =>
        dst <= a and b;
      when "0110" =>
        dst <= a or b;
      when "0111" =>
        dst <= a + 1;
      when "1000" =>
        dst <= (not a) + 1;
      when "1001" =>
        dst <= a(7 downto 0) & b(7 downto 0);
      when "1010" =>
        dst <= a;
      when "1011" =>
        dst <= rand;
      when "1100" =>
        dst <= "00" & (a(6 downto 0) * b(6 downto 0));
      when "1101" => -- shift right
        dst <= std_logic_vector(shr(unsigned(a), unsigned(b)));
      when "1110" => -- less eq
        dst <= x"0001" when a <= b else
          x"0000";
      when others =>
        dst <= x"0000";
    end case;
  end process funit;

end arch;