----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2022 11:59:15 PM
-- Design Name: 
-- Module Name: test - Behavioral
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

entity test is
  port (
    led : out std_logic_vector (15 downto 0);
    an : out std_logic_vector (3 downto 0);
    seg : out std_logic_vector (6 downto 0)
  );
end test;

architecture Behavioral of test is
  component top_level is
    port (
      sw : in std_logic_vector (15 downto 0);
      led : out std_logic_vector (15 downto 0);
      dp : out std_logic;
      an : out std_logic_vector (3 downto 0);
      seg : out std_logic_vector (6 downto 0);
      -- btn : in std_logic_vector (4 downto 0);
      clk : in std_logic
    );
  end component;
  signal clk : std_logic := '0';
  constant half_period : time := 50ns;

  signal btn : std_logic_vector(3 downto 0) := "0000";

begin
  clk <= not clk after half_period;
  top_level_inst : top_level port map(
    sw => x"0001",
    led => led,
    dp => open,
    an => an,
    seg => seg,
    -- btn => "00000",
    clk => clk
  );

  process
  begin

  end process;

end Behavioral;