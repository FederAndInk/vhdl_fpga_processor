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
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

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
    btn : in std_logic_vector (4 downto 0);
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

  component btn_pulse
    port (
      clk : in std_logic;
      inp : in std_logic;
      E : in std_logic;
      outp : out std_logic
    );
  end component;
  signal btn_clean : std_logic_vector (4 downto 0) := "00000";

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
    generic (
      NPROC : integer;
      PROC_NO : integer
    );
    port (
      sw : in std_logic_vector (15 downto 0);
      led : out std_logic_vector (15 downto 0);
      seg : out std_logic_vector (15 downto 0);
      btn_continue : in std_logic;
      clk : in std_logic
    );
  end component;

  signal seg_val : std_logic_vector (15 downto 0);

  constant NPROC : integer := 2;

  type arrayNPROC is array (0 to NPROC) of std_logic_vector(15 downto 0);
  signal segs : arrayNPROC := (others => x"0000");

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

  btn_cleaner : for I in 0 to 4 generate
    btn_pulse_inst : btn_pulse
    port map(
      clk => clk,
      inp => btn(I),
      E => E190,
      outp => btn_clean(I)
    );
  end generate; -- btn_cleaner

  procs : for I in 0 to NPROC - 1 generate
    regs_inst : regs
    generic map(
      NPROC => NPROC,
      PROC_NO => I
    )
    port map(
      sw => sw,
      led => open,
      seg => segs(I),
      btn_continue => btn_clean(4),
      clk => clk
    );
  end generate; -- procs

  -- addss : for I in 0 to NPROC / 2 - 1 generate
  seg_val <= segs(0) + segs(1);
  -- end generate addss;

  all_7seg_fsm_inst : all_7seg_fsm
  port map(
    clk => clk190,
    E => E190,
    val => seg_val,
    an => an,
    seg => seg
  );
end Behavioral;