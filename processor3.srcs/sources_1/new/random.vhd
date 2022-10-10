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
  generic (
    NPROC : integer;
    PROC_NO : integer
  );
  port (
    E : in std_logic;
    R : out std_logic_vector(15 downto 0);
    rst : in std_logic;
    clk : in std_logic
  );
end random;

architecture Behavioral of random is
  type array8 is array (0 to 7) of std_logic_vector(15 downto 0);
  constant rand_init_array : array8 := (x"8000", x"4000", x"2000", x"1000", x"8800", x"4400", x"2200", x"1100");
begin
  proc_name : process (clk, rst)
    variable val : std_logic_vector(15 downto 0) := rand_init_array(PROC_NO);
  begin
    if rst = '1' then
      val := rand_init_array(PROC_NO);
    elsif rising_edge(clk) then
      if E = '1' then
        for i in 0 to NPROC - 1 loop
          val := (val(0) xor val(1) xor val(3) xor val(12)) & val(15 downto 1);
        end loop;
      end if;
    end if;
    R <= val;
  end process proc_name;
end Behavioral;