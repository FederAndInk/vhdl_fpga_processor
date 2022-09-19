----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/12/2022 10:22:25 AM
-- Design Name: 
-- Module Name: proc_fsm - Behavioral
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

entity proc_fsm is
  port (
    clk : in std_logic;

    COinc : out std_logic;
    RILoad : out std_logic;

    instr : in std_logic_vector(15 downto 0);
    src : out std_logic_vector(3 downto 0);
    dest : out std_logic_vector(3 downto 0);
    op : out std_logic_vector(3 downto 0)
  );
end proc_fsm;

architecture Behavioral of proc_fsm is
  type state_t is (st_load);
  signal state, next_state : state_t := st_load; -- initialize the fucking state or it doesn't work on the board

  signal COinc_res : std_logic;
  signal RILoad_res : std_logic;
  signal B2R7seg_res : std_logic;
  signal RI2B_res : std_logic;
  signal src_res : std_logic_vector(3 downto 0);
  signal dest_res : std_logic_vector(3 downto 0);
  signal op_res : std_logic_vector(3 downto 0);
begin
  SYNC_PROC : process (clk)
  begin
    if (clk'event and clk = '1') then
      state <= next_state;
      COinc <= COinc_res;
      RILoad <= RILoad_res;
      src <= src_res;
      dest <= dest_res;
      op <= op_res;
    end if;
  end process;

  --MOORE State-Machine - Outputs based on state only
  OUTPUT_DECODE : process (state, instr)
  begin
    COinc_res <= '0';
    RILoad_res <= '0';
    op_res <= x"0";
    src_res <= x"0";
    dest_res <= x"0";
    case(state) is
      when st_load =>
      COinc_res <= '1';
      RILoad_res <= '1';
      case(instr(15 downto 12)) is
        when x"0" => -- move
        src_res <= instr(7 downto 4);
        dest_res <= instr(3 downto 0);
        when x"1" => -- alu
        op_res <= instr(11 downto 8);
        src_res <= x"0";
        dest_res <= x"B";
        when others =>
      end case;
    end case;
  end process;

  NEXT_STATE_DECODE : process (state)
  begin
    --declare default state for next_state to avoid latches
    next_state <= state; --default is to stay in current state
    case(state) is
      when st_load =>
      next_state <= st_load;
    end case;
  end process;
end Behavioral;