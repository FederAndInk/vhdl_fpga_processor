library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity ALU is
  port (
    a : in std_logic_vector(15 downto 0);
    b : in std_logic_vector(15 downto 0);
    op : in std_logic_vector(3 downto 0);
    dst : out std_logic_vector(15 downto 0)
  );
end ALU;

architecture arch of ALU is
begin
  funit : process (a, b, op)
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
      when others =>
        dst <= x"0000";
    end case;
  end process funit;

end arch;