----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/05/2022 09:08:12 AM
-- Design Name: 
-- Module Name: register - Behavioral
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

entity reg is
  port (
    B2R : in std_logic; -- bus to register
    R2B : in std_logic; -- register to bus
    clk : in std_logic;
    d : in std_logic_vector (15 downto 0);
    q : out std_logic_vector (15 downto 0);
    q_inside : out std_logic_vector (15 downto 0)
  );
end reg;

architecture Behavioral of reg is
begin
  process (clk, R2B, B2R)
    variable r : std_logic_vector(15 downto 0) := x"0000";
  begin
    if rising_edge(clk) then
      if B2R = '1' then
        r := d;
      end if;
    end if;

    if R2B = '1' then -- tri-state
      q <= r;
    else
      q <= "ZZZZZZZZZZZZZZZZ";
    end if;

    q_inside <= r;
  end process;
end Behavioral;