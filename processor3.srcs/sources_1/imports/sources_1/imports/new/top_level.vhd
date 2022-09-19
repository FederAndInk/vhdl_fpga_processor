----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/05/2022 08:46:33 AM
-- Design Name: 
-- Module Name: top_level - Behavioral
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

entity top_level is
  port (
    sw : in std_logic_vector (15 downto 0);
    led : out std_logic_vector (15 downto 0);
    dp : out std_logic;
    an : out std_logic_vector (3 downto 0);
    seg : out std_logic_vector (6 downto 0);
    -- btn : in std_logic_vector (4 downto 0);
    clk : in std_logic
  );
end top_level;

architecture Behavioral of top_level is
  component clkdiv is
    port (
      clk : in std_logic;
      reset : in std_logic;
      E190, clk190 : out std_logic
      -- E762, clk762 : out std_logic
    );
  end component;
  signal E190 : std_logic;
  signal clk190 : std_logic;
  signal E762 : std_logic;
  signal clk762 : std_logic;

  component all_7seg_fsm is
    port (
      clk : in std_logic;
      E : in std_logic;
      val : in std_logic_vector (15 downto 0);
      an : out std_logic_vector (3 downto 0);
      seg : out std_logic_vector (6 downto 0)
    );
  end component;

  component regs is
    port (
      sw : in std_logic_vector (15 downto 0);
      led : out std_logic_vector (15 downto 0);
      seg : out std_logic_vector (15 downto 0);
      clk : in std_logic
    );
  end component;

  signal seg_val : std_logic_vector (15 downto 0);

begin
  clkdiv_inst : clkdiv
  port map(
    clk => clk,
    reset => '0',
    E190 => E190,
    clk190 => clk190
    -- E762 => E762,
    -- clk762 => clk762
  );

  regs_inst : regs
  port map(
    sw => sw,
    led => led,
    seg => seg_val,
    clk => clk
  );

  all_7seg_fsm_inst : all_7seg_fsm
  port map(
    clk => clk190,
    E => E190,
    val => seg_val,
    an => an,
    seg => seg
  );
end Behavioral;