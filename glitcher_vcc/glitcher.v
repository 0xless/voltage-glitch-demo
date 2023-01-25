`timescale 1ns / 1ps

module main
(
    input clk,
    
    output led0,
    output led1,
    output led2,
    output led3,
    output led4,
    output g
);
	 
	reg glitch_reg;
	reg led0_reg;
	reg led2_reg;
	
	reg[27:0] f_counter=28'd0;
	reg[27:0] init_delay=28'd24000000;
	
	// glitch frequency
	reg[27:0] counter=28'd0;
	reg[27:0] freq=28'd70000;
	
	// glitch length
	reg[27:0] g_counter=28'd0;
	reg[27:0] g_len=28'd600;
	//reg[27:0] g_len=28'd200;

	// state machine register
	reg [1:0] state;

	// states
	localparam idle = 0;
	localparam glitch = 1;
	localparam first = 2;

	// OUTPUT
	assign led0 = led0_reg;
	assign led2 = led2_reg;
	assign g = glitch_reg;
	
	assign led1 = 1'b0;
	//assign led2 = 1'b0;
	assign led3 = 1'b0;
	assign led4 = 1'b0;
	

	// INITIAL ASSIGNMENTS
	initial 
	begin
		glitch_reg <= 1'b1;
		led0_reg <= 1'b0;
		led2_reg <= 1'b1;
		state <= first;
	end

	always @ (posedge clk) 
		begin
			case(state)
				first: 
				begin
					led2_reg <= 1'b1;
					f_counter <= f_counter + 28'd1;
					if(f_counter >= init_delay)
					begin
						f_counter <= 28'd0;
						state <= glitch;
						led2_reg <= 1'b0;
					end
				end
				
				idle: 
				begin
					counter <= counter + 28'd1;
					led0_reg <= 1'b0;
					if(counter >= freq)
					begin
						counter <= 28'd0;
						state <= glitch;
					end
				end
			
				glitch: 
				begin
					glitch_reg <= 0;
					g_counter <= g_counter + 28'd1;
					
					if(g_counter >= g_len)
					begin
						led0_reg <= 1'b1;
						g_counter <= 28'd0;
						glitch_reg <= 1;
						state <= idle;
						freq <= freq + 28'b10; //move the glitch insertion point 
					end
				end
			endcase
		end

endmodule
