----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/03/2022 08:50:42 AM
-- Design Name: 
-- Module Name: random - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity random is
  port (
    E : in std_logic;
    R : out std_logic_vector(15 downto 0);
    rst : in std_logic;
    clk : in std_logic
  );
end random;

architecture Behavioral of random is
  signal val : std_logic_vector(15 downto 0) := x"8000";
begin
  R <= val;

  proc_name : process (clk, rst)
  begin
    if rst = '1' then
      val <= x"8000";
    elsif rising_edge(clk) then
      if E = '1' then
        val <= (val(0) xor val(1) xor val(3) xor val(12)) & val(15 downto 1);
      end if;
    end if;
  end process proc_name;
end Behavioral;