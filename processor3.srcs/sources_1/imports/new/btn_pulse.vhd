----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2022 03:06:47 PM
-- Design Name: 
-- Module Name: btn_pulse - Behavioral
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

entity btn_pulse is
  port (
    clk : in std_logic;
    inp : in std_logic;
    E : in std_logic;
    outp : out std_logic
  );
end btn_pulse;

architecture Behavioral of btn_pulse is
  signal Q0, Q1, Q2, Q3, Q4, Q5 : std_logic;
begin
  detector : process (clk)
  begin
    if rising_edge(clk) then
      if E = '1' then
        Q0 <= inp;
        Q1 <= Q0;
        Q2 <= Q1;
      end if;

      Q3 <= Q0 and Q1 and Q2;
      Q4 <= Q3;
      Q5 <= Q4;

    end if;
  end process; -- detector
  outp <=  Q3 and Q4 and not Q5;
end Behavioral;