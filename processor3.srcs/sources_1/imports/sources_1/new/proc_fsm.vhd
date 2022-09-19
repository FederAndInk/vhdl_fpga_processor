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
    B2R7seg : out std_logic;
    RI2B : out std_logic;
    B2CO : out std_logic
  );
end proc_fsm;

architecture Behavioral of proc_fsm is
  type state_t is (st_load, st_transfer, st_transfer2);
  signal state, next_state : state_t := st_load; -- initialize the fucking state or it doesn't work on the board

  signal COinc_res : std_logic;
  signal RILoad_res : std_logic;
  signal B2R7seg_res : std_logic;
  signal RI2B_res : std_logic;
  signal B2CO_res : std_logic;
begin
  SYNC_PROC : process (clk)
  begin
    if (clk'event and clk = '1') then
      state <= next_state;
      COinc <= COinc_res;
      RILoad <= RILoad_res;
      B2R7seg <= B2R7seg_res;
      RI2B <= RI2B_res;
      B2CO <= B2CO_res;
    end if;
  end process;

  --MOORE State-Machine - Outputs based on state only
  OUTPUT_DECODE : process (state)
  begin
    COinc_res <= '0';
    RILoad_res <= '0';
    B2R7seg_res <= '0';
    RI2B_res <= '0';
    B2CO_res <= '0';
    case(state) is
      when st_load =>
      COinc_res <= '1';
      RILoad_res <= '1';
      when st_transfer =>
      B2R7seg_res <= '1';
      RI2B_res <= '1';
      COinc_res <= '1';
      RILoad_res <= '1';
      when st_transfer2 =>
      B2R7seg_res <= '1';
      RI2B_res <= '1';
    end case;
  end process;

  NEXT_STATE_DECODE : process (state)
  begin
    --declare default state for next_state to avoid latches
    next_state <= state; --default is to stay in current state
    case(state) is
      when st_load =>
      next_state <= st_transfer;
      when st_transfer =>
      next_state <= st_transfer2;
      when st_transfer2 =>
      next_state <= st_transfer2;
    end case;
  end process;
end Behavioral;