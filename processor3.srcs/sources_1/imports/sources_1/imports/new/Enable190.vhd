library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

entity clkdiv is
  port (
    clk : in std_logic;
    reset : in std_logic;
    E190, clk190 : out std_logic
    -- E762, clk762 : out std_logic
  );
end clkdiv;

architecture clkdiv of clkdiv is
  signal clkin : std_logic := '0';
  -- signal clkin2 : std_logic := '0';
begin
  --clock divider     
  process (clk, reset)
    variable q : std_logic_vector(23 downto 0) := X"000000";
  begin
    if reset = '1' then
      q := X"000000";
      clkin <= '0';
      -- clkin2 <= '0';
    elsif clk'event and clk = '1' then
      q := q + 1;
      if Q(16) = '1' and clkin = '0' then
        E190 <= '1';
      else
        E190 <= '0';
      end if;
      -- if Q(16) = '1' and clkin2 = '0' then
      --   E762 <= '1';
      -- else
      --   E762 <= '0';
      -- end if;
    end if;
    clkin <= Q(16);
    -- clkin2 <= Q(16);
  end process;
  clk190 <= clkin;
  -- clk762 <= clkin2;
end clkdiv;