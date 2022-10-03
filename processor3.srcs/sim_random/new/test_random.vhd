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

entity test_random is
  port (
    led : out std_logic_vector (15 downto 0)
  );
end test_random;

architecture Behavioral of test_random is
  component random is
    port (
      E : in std_logic;
      R : out std_logic_vector(15 downto 0);
      rst : in std_logic;
      clk : in std_logic
    );
  end component;
  signal clk : std_logic := '0';
  constant half_period : time := 50ns;

  signal btn : std_logic_vector (4 downto 0) := "00000";
  signal sw : std_logic_vector (15 downto 0) := x"0052";
begin
  clk <= not clk after half_period;
  random_inst : random
  port map(
    E => '1',
    R => led,
    rst => '0',
    clk => clk
  );

  -- process
  -- begin
  --   wait for 900 ns;
  --   sw <= x"0004";
  --   wait for 1000 ns;
  --   btn <= "10000";
  --   wait for 1000 ns;
  -- end process;

end Behavioral;