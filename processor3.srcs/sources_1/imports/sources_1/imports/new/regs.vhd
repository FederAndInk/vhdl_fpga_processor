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
  component RI_reg is
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
  signal COLoad : std_logic;

  component proc_fsm is
    port (
      clk : in std_logic;
      continue : in std_logic;

      COinc : out std_logic;
      COLoad : out std_logic;
      RILoad : out std_logic;

      instr : in std_logic_vector(15 downto 0);
      src : out std_logic_vector(3 downto 0);
      dest : out std_logic_vector(3 downto 0);
      op : out std_logic_vector(3 downto 0);

      test_Z, test_NZ, E_alu : out std_logic
    );
  end component;

  signal test_Z, test_NZ, E_alu : std_logic;
  signal do_decode_dest : std_logic;

  signal COinc : std_logic;
  signal RILoad : std_logic;
  signal R2B : std_logic_vector(15 downto 0);
  signal B2R : std_logic_vector(15 downto 0);
  signal srcInst : std_logic_vector(3 downto 0);
  signal dstInst : std_logic_vector(3 downto 0);

  component inst2regdecoder is
    port (
      instReg : in std_logic_vector(3 downto 0);
      busReg : out std_logic_vector(15 downto 0);
      E : in std_logic
    );
  end component;

  component ALU is
    generic (
      NPROC : integer;
      PROC_NO : integer
    );
    port (
      E : in std_logic;
      a : in std_logic_vector(15 downto 0);
      b : in std_logic_vector(15 downto 0);
      op : in std_logic_vector(3 downto 0);
      dst : out std_logic_vector(15 downto 0);
      clk : in std_logic
    );
  end component;
  signal destd : std_logic_vector (15 downto 0);
  signal destInside : std_logic_vector (15 downto 0);
  signal dest_is_zero : std_logic := '0';
  signal src1q : std_logic_vector (15 downto 0);
  signal src2q : std_logic_vector (15 downto 0);
  signal op : std_logic_vector(3 downto 0);
begin
  R1 : reg
  port map(
    B2R => B2R(1),
    R2B => R2B(1),
    clk => clk,
    d => dbus,
    q => dbus,
    q_inside => open
  );
  R2 : reg
  port map(
    B2R => B2R(2),
    R2B => R2B(2),
    clk => clk,
    d => dbus,
    q => dbus,
    q_inside => open
  );
  R3 : reg
  port map(
    B2R => B2R(3),
    R2B => R2B(3),
    clk => clk,
    d => dbus,
    q => dbus,
    q_inside => open
  );
  R4 : reg
  port map(
    B2R => B2R(4),
    R2B => R2B(4),
    clk => clk,
    d => dbus,
    q => dbus,
    q_inside => open
  );
  R5 : reg
  port map(
    B2R => B2R(5),
    R2B => R2B(5),
    clk => clk,
    d => dbus,
    q => dbus,
    q_inside => open
  );
  Rout1 : reg
  port map(
    B2R => B2R(6),
    R2B => R2B(6),
    clk => clk,
    d => dbus,
    q => dbus,
    q_inside => led
  );
  Rin : reg
  port map(
    B2R => '1',
    R2B => R2B(7),
    clk => clk,
    d => sw,
    q => dbus,
    q_inside => open
  );
  Rout2 : reg
  port map(
    B2R => B2R(8),
    R2B => R2B(8),
    clk => clk,
    d => dbus,
    q => dbus,
    q_inside => seg
  );
  Rsrc1 : reg
  port map(
    B2R => B2R(9),
    R2B => R2B(9),
    clk => clk,
    d => dbus,
    q => dbus,
    q_inside => src1q
  );
  Rsrc2 : reg
  port map(
    B2R => B2R(10),
    R2B => R2B(10),
    clk => clk,
    d => dbus,
    q => dbus,
    q_inside => src2q
  );
  Rdest : reg
  port map(
    B2R => B2R(11),
    R2B => R2B(11),
    clk => clk,
    d => destd,
    q => dbus,
    q_inside => destInside
  );
  dest_is_zero <= '1' when destInside = x"0000" else
    '0';

  RAM : reg
  port map(
    B2R => B2R(12),
    R2B => R2B(12),
    clk => clk,
    d => dbus,
    q => dbus,
    q_inside => open
  );
  RDM : reg
  port map(
    B2R => B2R(13),
    R2B => R2B(13),
    clk => clk,
    d => dbus,
    q => dbus,
    q_inside => open
  );
  CO : reg
  port map(
    B2R => COLoad,
    R2B => R2B(14),
    clk => clk,
    d => COd,
    q => dbus,
    q_inside => COInside
  );

  COd <= dbus when B2R(14) = '1' else
    (COInside + x"0001") when COinc = '1' else
    COInside;

  RI : RI_reg
  port map(
    B2R => RILoad,
    R2B => R2B(15),
    clk => clk,
    d => instruction,
    q => dbus,
    q_inside => open
  );

  proc_fsm_inst : proc_fsm
  port map(
    clk => clk,
    continue => btn_continue,
    COinc => COinc,
    COLoad => COLoad,
    RILoad => RILoad,
    instr => instruction,
    src => srcInst,
    dest => dstInst,
    op => op,
    test_Z => test_Z,
    test_NZ => test_NZ,
    E_alu => E_alu
  );

  ALU_inst : ALU
  generic map(
    NPROC => NPROC,
    PROC_NO => PROC_NO
  )
  port map(
    E => E_alu,
    a => src1q,
    b => src2q,
    op => op,
    dst => destd,
    clk => clk
  );

  inst2regdecoder_src : inst2regdecoder
  port map(
    instReg => srcInst,
    busReg => R2B,
    E => '1'
  );
  inst2regdecoder_dst : inst2regdecoder
  port map(
    instReg => dstInst,
    busReg => B2R,
    E => do_decode_dest
  );
  do_decode_dest <= (test_NZ and not dest_is_zero)
    or (test_Z and dest_is_zero)
    or not (test_Z or test_NZ);
  inst_mem_inst : inst_mem
  port map(
    a => COInside(7 downto 0),
    spo => instruction
  );
end Behavioral;