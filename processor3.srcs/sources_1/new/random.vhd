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
  type array8 is array (0 to 31) of std_logic_vector(15 downto 0);
  constant rand_init_array : array8 := (x"8000", x"4000", x"2000", x"1000", x"8800", x"4400", x"2200", x"1100",
  x"8880", x"4440", x"2220", x"1110", x"8888", x"c444", x"6222", x"b111",
  x"5888", x"2c44", x"1622", x"0b11", x"8588", x"c2c4", x"6162", x"b0b1",
  x"5858", x"2c2c", x"9616", x"4b0b", x"a585", x"d2c2", x"6961", x"b4b0");
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