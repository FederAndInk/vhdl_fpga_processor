----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/19/2022 09:37:51 AM
-- Design Name: 
-- Module Name: inst2regdecoder - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity inst2regdecoder is
  port (
    instReg : in std_logic_vector(3 downto 0);
    busReg : out std_logic_vector(15 downto 0);
    E : in std_logic
  );
end inst2regdecoder;

architecture Behavioral of inst2regdecoder is
begin
  busReg <= x"0000" when E = '0' else
    x"0002" when instReg = x"1" else
    x"0004" when instReg = x"2" else
    x"0008" when instReg = x"3" else
    x"0010" when instReg = x"4" else
    x"0020" when instReg = x"5" else
    x"0040" when instReg = x"6" else
    x"0080" when instReg = x"7" else
    x"0100" when instReg = x"8" else
    x"0200" when instReg = x"9" else
    x"0400" when instReg = x"A" else
    x"0800" when instReg = x"B" else
    x"1000" when instReg = x"C" else
    x"2000" when instReg = x"D" else
    x"4000" when instReg = x"E" else
    x"8000" when instReg = x"F" else
    x"0000";
end Behavioral;