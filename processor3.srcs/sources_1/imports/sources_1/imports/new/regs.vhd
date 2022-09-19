----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/05/2022 08:46:33 AM
-- Design Name: 
-- Module Name: regs - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity regs is
  port (
    sw : in std_logic_vector (15 downto 0);
    led : out std_logic_vector (15 downto 0);
    seg : out std_logic_vector (15 downto 0);
    clk : in std_logic;

    COinc : in std_logic;
    RILoad : in std_logic;
    B2R7seg : in std_logic;
    RI2B : in std_logic;
    B2CO : in std_logic
  );
end regs;

architecture Behavioral of regs is
  component reg is
    port (
      B2R : in std_logic; -- bus to register
      R2B : in std_logic; -- register to bus
      clk : in std_logic;
      d : in std_logic_vector (15 downto 0);
      q : out std_logic_vector (15 downto 0);
      q_inside : out std_logic_vector (15 downto 0)
    );
  end component;

  component inst_mem
    port (
      a : in std_logic_vector (7 downto 0);
      spo : out std_logic_vector (15 downto 0)
    );
  end component;
  signal instruction : std_logic_vector (15 downto 0);

  signal dbus : std_logic_vector (15 downto 0);

  signal COd : std_logic_vector (15 downto 0);
  signal COInside : std_logic_vector (15 downto 0);
begin
  R1 : reg
  port map(
    B2R => '0',
    R2B => '0',
    clk => clk,
    d => dbus,
    q => dbus,
    q_inside => open
  );
  R2 : reg
  port map(
    B2R => '0',
    R2B => '0',
    clk => clk,
    d => dbus,
    q => dbus,
    q_inside => open
  );
  R3 : reg
  port map(
    B2R => '0',
    R2B => '0',
    clk => clk,
    d => dbus,
    q => dbus,
    q_inside => open
  );
  R4 : reg
  port map(
    B2R => '0',
    R2B => '0',
    clk => clk,
    d => dbus,
    q => dbus,
    q_inside => open
  );
  R5 : reg
  port map(
    B2R => '0',
    R2B => '0',
    clk => clk,
    d => dbus,
    q => dbus,
    q_inside => open
  );
  Rin : reg
  port map(
    B2R => '1',
    R2B => '0', -- temporarily set to 1
    clk => clk,
    d => sw,
    q => dbus,
    q_inside => open
  );
  Rout1 : reg
  port map(
    B2R => '1', -- temporarily set to 1
    R2B => '0',
    clk => clk,
    d => dbus,
    q => dbus,
    q_inside => led
  );
  Rout2 : reg
  port map(
    B2R => B2R7seg,
    R2B => '0',
    clk => clk,
    d => dbus,
    q => dbus,
    q_inside => seg
  );
  Rsrc1 : reg
  port map(
    B2R => '0',
    R2B => '0',
    clk => clk,
    d => dbus,
    q => dbus,
    q_inside => open
  );
  Rsrc2 : reg
  port map(
    B2R => '0',
    R2B => '0',
    clk => clk,
    d => dbus,
    q => dbus,
    q_inside => open
  );
  Rdest : reg
  port map(
    B2R => '0',
    R2B => '0',
    clk => clk,
    d => dbus,
    q => dbus,
    q_inside => open
  );
  RAM : reg
  port map(
    B2R => '0',
    R2B => '0',
    clk => clk,
    d => dbus,
    q => dbus,
    q_inside => open
  );
  RDM : reg
  port map(
    B2R => '0',
    R2B => '0',
    clk => clk,
    d => dbus,
    q => dbus,
    q_inside => open
  );
  CO : reg
  port map(
    B2R => '1',
    R2B => '0',
    clk => clk,
    d => COd,
    q => dbus,
    q_inside => COInside
  );

  COd <= dbus when B2CO = '1' else
    (COInside + x"0001") when COinc = '1' else
    COInside;

  RI : reg
  port map(
    B2R => RILoad,
    R2B => RI2B,
    clk => clk,
    d => instruction,
    q => dbus,
    q_inside => open
  );

  inst_mem_inst : inst_mem
  port map(
    a => COInside(7 downto 0),
    spo => instruction
  );
end Behavioral;