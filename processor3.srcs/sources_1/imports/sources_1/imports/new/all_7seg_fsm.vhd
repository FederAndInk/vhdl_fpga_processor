----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2022 12:43:01 PM
-- Design Name: 
-- Module Name: all_7seg_fsm - Behavioral
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

entity all_7seg_fsm is
  port (
    clk : in std_logic;
    E : in std_logic;
    val : in std_logic_vector (15 downto 0);
    an : out std_logic_vector (3 downto 0);
    seg : out std_logic_vector (6 downto 0)
  );
end all_7seg_fsm;

architecture Behavioral of all_7seg_fsm is
  component x7seg is
    port (
      val : in std_logic_vector (3 downto 0);
      seg : out std_logic_vector (6 downto 0)
    );
  end component;

  type state_t is (st_digit1, st_digit2, st_digit3, st_digit4);
  signal state, next_state : state_t := st_digit1;

  signal an_res : std_logic_vector (3 downto 0) := (others => '0');
  signal seg_res : std_logic_vector (6 downto 0) := (others => '0');
  signal val_res : std_logic_vector (3 downto 0) := (others => '0');
begin
  x7seg_inst : x7seg
  port map(
    val => val_res,
    seg => seg_res
  );

  SYNC_PROC : process (clk)
  begin
    if (clk'event and clk = '1') then
      state <= next_state;
      an <= an_res;
      seg <= seg_res;
    end if;
  end process;

  --MOORE State-Machine - Outputs based on state only
  OUTPUT_DECODE : process (state)
  begin
    case(state) is
      when st_digit1 =>
      an_res <= "1110";
      val_res <= val(3 downto 0);
      when st_digit2 =>
      an_res <= "1101";
      val_res <= val(7 downto 4);
      when st_digit3 =>
      an_res <= "1011";
      val_res <= val(11 downto 8);
      when st_digit4 =>
      an_res <= "0111";
      val_res <= val(15 downto 12);
    end case;
  end process;

  NEXT_STATE_DECODE : process (state, E)
  begin
    --declare default state for next_state to avoid latches
    next_state <= state; --default is to stay in current state
    if (E = '1') then
      case(state) is
        when st_digit1 =>
        next_state <= st_digit2;
        when st_digit2 =>
        next_state <= st_digit3;
        when st_digit3 =>
        next_state <= st_digit4;
        when st_digit4 =>
        next_state <= st_digit1;
      end case;
    end if;
  end process;
end Behavioral;