`timescale 1ns / 1ps


module music(
    input [1:0] status,
    input clk,
    input reset,
    input ssel,
    output reg speaker,
    output a_enable
    );
    
    assign a_enable = 1;
    
    wire speaker1, speaker2, speaker3, speaker4, speaker5;
    wire clk1, clk2, clk3, clk4, clk5;
    assign clk1 = clk & (~status[0] & ~status[1]); // gameplay
    assign clk2 = clk & (status[0] & ~status[1]); // gameover
    assign clk3 = clk & (~status[0] & status[1] & ~ssel); // win
//    assign clk4 = clk & (~status[0] & ~status[1] & ssel);
    assign clk5 = clk & (~status[0] & status[1] & ssel);
    music1 M1(clk1, reset, speaker1);
    music2 M2(clk2, reset, speaker2);
    music3 M3(clk3, reset, speaker3);
//    music4 M4(clk4, reset, speaker4);
    music5 M5(clk5, reset, speaker5);
//    musicsel #(1871) M1(clk1, reset, 0, speaker1);
//    musicsel #(975) M2(clk2, reset, 1, speaker2);
//    musicsel #(3151) M3(clk3, reset, 2, speaker3);
    always @(*)
    begin
        case (status)
            2'b00: speaker = speaker1;
            2'b01: speaker = speaker2;
            2'b10: 
            begin 
                if (~ssel)
                    speaker = speaker3;
                else
                    speaker = speaker5;
            end
            default: speaker = 0;
        endcase
    end
    
endmodule

module wave(
	input clk,
	input [7:0] node,
	output reg wav
	);
	
	reg [31:0] cnt;
	reg [31:0] max;
	
	always @(*)
	begin
		case (node)
			0: max=-1;
			8'h02: max = 454545;
            8'h12: max = 429033;
            8'h22: max = 404953;
            8'h32: max = 382225;
            8'h42: max = 360772;
            8'h52: max = 340524;
            8'h62: max = 321412;
            8'h72: max = 303372;
            8'h82: max = 286345;
            8'h92: max = 270274;
            8'hA2: max = 255105;
            8'hB2: max = 240787;
			8'h03: max = 227272;
            8'h13: max = 214516;
            8'h23: max = 202476;
            8'h33: max = 191112;
            8'h43: max = 180386;
            8'h53: max = 170262;
            8'h63: max = 160706;
            8'h73: max = 151686;
            8'h83: max = 143172;
            8'h93: max = 135137;
            8'hA3: max = 127552;
            8'hB3: max = 120393;
			8'h04: max = 113636;
            8'h14: max = 107250;
            8'h24: max = 101235;
            8'h34: max = 95547;
            8'h44: max = 90187;
            8'h54: max = 85135;
            8'h64: max = 80347;
            8'h74: max = 75838;
            8'h84: max = 71581;
            8'h94: max = 67567;
            8'hA4: max = 63775;
            8'hB4: max = 60197;
            8'h05: max = 56818;
            8'h15: max = 53630;
            8'h25: max = 50617;
            8'h35: max = 47778;
            8'h45: max = 45097;
            8'h55: max = 42564;
            8'h65: max = 40176;
            8'h75: max = 37921;
            8'h85: max = 35793;
            8'h95: max = 33783;
            8'hA5: max = 31887;
            8'hB5: max = 30098;
            8'h06: max = 28409;
            8'h16: max = 26813;
            8'h26: max = 25310;
            8'h36: max = 23889;
            8'h46: max = 22547;
            8'h56: max = 21282;
            8'h66: max = 20088;
            8'h76: max = 18960;
            8'h86: max = 17896;
            8'h96: max = 16891;
            8'hA6: max = 15943;
            8'hB6: max = 15049;
            8'h07: max = 14204;
            8'h17: max = 13407;
            8'h27: max = 12654;
            8'h37: max = 11944;
            8'h47: max = 11274;
            8'h57: max = 10641;
            8'h67: max = 10044;
            8'h77: max = 9480;
            8'h87: max = 8948;
            8'h97: max = 8446;
            8'hA7: max = 7972;
            8'hB7: max = 7524;
            default: max = -1;
		endcase
	end
	
	always @(posedge clk)
	begin
//		if (cnt >= max)
//		begin
//			cnt <= 0;
//			wav <= ~wav;
//		end
//		else
//			cnt <= cnt+1;
        if (cnt >= max * 2)
        begin
            cnt <= 0;
        end
        else
        begin
            cnt <= cnt + 1;
            if (cnt >= max * 63 / 32)
                wav <= 1;
            else
                wav <= 0;
        end
	end
	
endmodule

//module musicROM(
//    input sel,
//    output reg [3151:0] music,
//    output reg [3151:0] delay // max
//    );
    
//    always @(*)
//    begin  
//        case (sel)
//            0: begin // gameplay bgm
//                music <= 1872'h55358585a5a506853555358585a5a5068555358585a5a506853555358585a58555358585a5a506853555358585a5a506a555358585a5a506853555358585a58555358585a5a506853555358585a5a506a555358585a5a506853555358585a585160685555585a55585355585160685555585a55585160685555585a555853555853585151535153515a43585a5a585555585a50636a506853585a5a5855555a5853606003585a5a585555585a50636a5068575557585757585003585a5a585555585a50636a506853585a5a5855555a5853606003585a5a585555585a50636a506857555758575758500;
//                delay <= 1872'h0404080808080808080404080808080810040408080808080808040408080820040408080808080808040408080808081004040808080808080804040808082004040808080808080804040808080808100404080808080808080404080808200404040404040404080808080404040404040404200404040404040404080808080c040c040404040404040404080404040404040404080404040408040404040404100404040408040404040404040408080810080404040c04040404080404040404040404080404040408040404040404100404040408040404040404040408080810080404081008;
//            end
//            1: begin
//                music <= 976'h7565452545b415944565759526b57565452545b415944464746424447565452545b415944565759526b57565452545b4159444647464244495755545255545b4b4459575554525554544942515b494b415b4444464749405b495755545255545b4b4459575554525554544942515b494b415b444446474642444;
//                delay <= 976'h0404040404040808040408080818040404040404080804040808081804040404040408080404080808180404040404040808040408080818040404040404080804040404040404041004040404040404040808040408080818040404040404080804040404040404041004040404040404040808040408080818;
//            end
//            2: begin
//                music <= 'h00556516a500a516856500651666363656361685a500a51666566636002616b5a51665a585355565a585655515650064a415353515355584a415846464143434a4846484a464a4158565a58565251565a4843584b425652515b46424b3638300a4a484a41554640064353515355585a4a43535a5851516856555356500b4658584158565a51685166516655516153535a5856585a516a5363616365685a516556585a5b5a5b5a58565b4a4b4a48464b3a3b3a38363b2a2b2a282621400005484153555851600a5a585a51655650065363616365685a565a5b5361616a586661685666685a5006686a6a686a6275666665666a616363616365685a500a5b53626a585a585655565a500a505056525b41584156585a5a585a51655656555651615353515351685a585a516866686666566853656662616b5652515b414548415a5a585a51655656555651615353515355516a5a536a6861617566686a6b6a6b6a68666b5a5b5a58565b4a4b4a48464b3a3b3a3836314538314345484153555158516650000005666170000;
//                delay <= 'h04040404100404040410040404040c04040404041004040404040408040404040404040404080408080404040410040404040c0404040404080404080404080404080404100404040408040808040804040408010101040404040404040410100c04040404041804040c04040404041808080404080808080c0408060208041404040404080808080804040804040804040804041008080808040404040804040804040401010104040401010104040401010104040401010104040808100404040404040404080804040404180404080804040404100c040808080808080808080808081008040408080404040408080404040408080404040418040408080404040404040404080404080808040410040404040c04040404040c04040404040c0404040404100404040418040408080804040404040404040404100404080808040404040c04040404040c0404040404180808080808080808040404010101040404010101040404010101040404010101040410040404040404040404040404101020040202100810;
//            end
//        endcase
//    end        
    
//endmodule

//module musicsel #(parameter WIDTH=3151, LEN=1724138)(
//    input clk,
//    input reset,
//    input [1:0] sel,
//    output speaker
//    );

//	reg [WIDTH:0] music;
//	reg [WIDTH:0] delay;    
	
//	reg [31:0] max;
//    reg [31:0] cnt = 0;
//    reg t;
//    reg [7:0] left = 1;
//    reg wt = 0;
//    reg [7:0] node = 0;
    
//    wave w(clk, node, speaker);
////    musicROM MROM(sel, music, delay);

//    task init_stuff;
//    begin
//        case (sel)
//                0: begin // gameplay bgm
//                    music <= 1872'h55358585a5a506853555358585a5a5068555358585a5a506853555358585a58555358585a5a506853555358585a5a506a555358585a5a506853555358585a58555358585a5a506853555358585a5a506a555358585a5a506853555358585a585160685555585a55585355585160685555585a55585160685555585a555853555853585151535153515a43585a5a585555585a50636a506853585a5a5855555a5853606003585a5a585555585a50636a5068575557585757585003585a5a585555585a50636a506853585a5a5855555a5853606003585a5a585555585a50636a506857555758575758500;
//                    delay <= 1872'h0404080808080808080404080808080810040408080808080808040408080820040408080808080808040408080808081004040808080808080804040808082004040808080808080804040808080808100404080808080808080404080808200404040404040404080808080404040404040404200404040404040404080808080c040c040404040404040404080404040404040404080404040408040404040404100404040408040404040404040408080810080404040c04040404080404040404040404080404040408040404040404100404040408040404040404040408080810080404081008;
//                end
//                1: begin
//                    music <= 976'h7565452545b415944565759526b57565452545b415944464746424447565452545b415944565759526b57565452545b4159444647464244495755545255545b4b4459575554525554544942515b494b415b4444464749405b495755545255545b4b4459575554525554544942515b494b415b444446474642444;
//                    delay <= 976'h0404040404040808040408080818040404040404080804040808081804040404040408080404080808180404040404040808040408080818040404040404080804040404040404041004040404040404040808040408080818040404040404080804040404040404041004040404040404040808040408080818;
//                end
//                2: begin
//                    music <= 'h00556516a500a516856500651666363656361685a500a51666566636002616b5a51665a585355565a585655515650064a415353515355584a415846464143434a4846484a464a4158565a58565251565a4843584b425652515b46424b3638300a4a484a41554640064353515355585a4a43535a5851516856555356500b4658584158565a51685166516655516153535a5856585a516a5363616365685a516556585a5b5a5b5a58565b4a4b4a48464b3a3b3a38363b2a2b2a282621400005484153555851600a5a585a51655650065363616365685a565a5b5361616a586661685666685a5006686a6a686a6275666665666a616363616365685a500a5b53626a585a585655565a500a505056525b41584156585a5a585a51655656555651615353515351685a585a516866686666566853656662616b5652515b414548415a5a585a51655656555651615353515355516a5a536a6861617566686a6b6a6b6a68666b5a5b5a58565b4a4b4a48464b3a3b3a3836314538314345484153555158516650000005666170000;
//                    delay <= 'h04040404100404040410040404040c04040404041004040404040408040404040404040404080408080404040410040404040c0404040404080404080404080404080404100404040408040808040804040408010101040404040404040410100c04040404041804040c04040404041808080404080808080c0408060208041404040404080808080804040804040804040804041008080808040404040804040804040401010104040401010104040401010104040401010104040808100404040404040404080804040404180404080804040404100c040808080808080808080808081008040408080404040408080404040408080404040418040408080404040404040404080404080808040410040404040c04040404040c04040404040c0404040404100404040418040408080804040404040404040404100404080808040404040c04040404040c0404040404180808080808080808040404010101040404010101040404010101040404010101040410040404040404040404040404101020040202100810;
//                end
//        endcase
//    end
//    endtask
    
//    initial begin
//        init_stuff;
//    end
    
//    always @(posedge clk or posedge reset)
//    begin
//       if (reset)
//           cnt <= 0;
//       else if (cnt >= max)
//       begin
//           cnt <= 0;
//           t <= ~t;
//       end
//       else
//           cnt <= cnt + 1;
//    end
    
        
//    always@(posedge t or posedge reset)
//    begin
//        if (reset)
//        begin
//            init_stuff;
//        end
//        else 
//        begin
//            left <= left - 1;
//            if (left == 1)
//            begin
//                if (wt)
//                begin
//                    music <= {music[WIDTH-8:0], music[WIDTH:WIDTH-7]};
//                    delay <= {delay[WIDTH-8:0], delay[WIDTH:WIDTH-7]};
//                    node <= music[WIDTH:WIDTH-7];
//                    left <= delay[WIDTH:WIDTH-7];
//                    max <= LEN;
//                    wt <= 0;
//                end
//                else
//                begin
//                    node <= 0;
//                    left <= 1;
//                    max <= 250000;
//                    wt <= 1;
//                end
//            end
//        end
//    end
    
//endmodule

module music3(
	input clk,
	input reset,
	output speaker
);
    parameter LEN = 3151;
	reg [LEN:0] music;
	reg [LEN:0] delay;
	
	reg [31:0] max;
	reg [31:0] cnt;
	reg t;
	reg [7:0] left = 0;
	reg wt = 0;
	reg [7:0] node;
	
	wave w(clk, node, speaker);
	
	task init_stuff;
	begin
	    left <= 1;
        wt <= 0;
        node <= 0;
        music <= 'h00556516a500a516856500651666363656361685a500a51666566636002616b5a51665a585355565a585655515650064a415353515355584a415846464143434a4846484a464a4158565a58565251565a4843584b425652515b46424b3638300a4a484a41554640064353515355585a4a43535a5851516856555356500b4658584158565a51685166516655516153535a5856585a516a5363616365685a516556585a5b5a5b5a58565b4a4b4a48464b3a3b3a38363b2a2b2a282621400005484153555851600a5a585a51655650065363616365685a565a5b5361616a586661685666685a5006686a6a686a6275666665666a616363616365685a500a5b53626a585a585655565a500a505056525b41584156585a5a585a51655656555651615353515351685a585a516866686666566853656662616b5652515b414548415a5a585a51655656555651615353515355516a5a536a6861617566686a6b6a6b6a68666b5a5b5a58565b4a4b4a48464b3a3b3a3836314538314345484153555158516650000005666170000;
        delay <= 'h04040404100404040410040404040c04040404041004040404040408040404040404040404080408080404040410040404040c0404040404080404080404080404080404100404040408040808040804040408010101040404040404040410100c04040404041804040c04040404041808080404080808080c0408060208041404040404080808080804040804040804040804041008080808040404040804040804040401010104040401010104040401010104040401010104040808100404040404040404080804040404180404080804040404100c040808080808080808080808081008040408080404040408080404040408080404040418040408080404040404040404080404080808040410040404040c04040404040c04040404040c0404040404100404040418040408080804040404040404040404100404080808040404040c04040404040c0404040404180808080808080808040404010101040404010101040404010101040404010101040410040404040404040404040404101020040202100810;
	end
	endtask
	
	initial begin
	   init_stuff;
	end
	
	always @(posedge clk or posedge reset)
	begin
	   if (reset)
	       cnt <= 0;
	   else if (cnt >= max)
	   begin
		   cnt <= 0;
		   t <= ~t;
	   end
	   else
		   cnt <= cnt + 1;
	end

	
	always@(posedge t or posedge reset)
	begin
		if (reset)
		begin
		  init_stuff;
		end
        else 
        begin
			left <= left - 1;
			if (left == 1)
			begin
				if (wt)
				begin
					music <= {music[LEN-8:0], music[LEN:LEN-7]};
					delay <= {delay[LEN-8:0], delay[LEN:LEN-7]};
					node <= music[LEN:LEN-7];
					left <= delay[LEN:LEN-7];
					max <= 1724138;
					wt <= 0;
				end
				else
				begin
					node <= 0;
					left <= 1;
					max <= 250000;
					wt <= 1;
				end
			end
		  end
	    end
endmodule

module music2(
	input clk,
	input reset,
	output speaker
);

    parameter LEN = 975;
	reg [LEN:0] music;
	reg [LEN:0] delay;
	
	reg [31:0] max;
	reg [31:0] cnt;
	reg t;
	reg [7:0] left=0;
	reg wt = 0;
	reg [7:0] node;
	
	task init_stuff;
	begin
	    left <= 1;
        wt <= 0;
        node <= 0;
        music <= 976'h7565452545b415944565759526b57565452545b415944464746424447565452545b415944565759526b57565452545b4159444647464244495755545255545b4b4459575554525554544942515b494b415b4444464749405b495755545255545b4b4459575554525554544942515b494b415b444446474642444;
        delay <= 976'h0404040404040808040408080818040404040404080804040808081804040404040408080404080808180404040404040808040408080818040404040404080804040404040404041004040404040404040808040408080818040404040404080804040404040404041004040404040404040808040408080818;
    end
    endtask
	
	wave w(clk, node, speaker);
	
	initial begin
	   init_stuff;
	end
	
	always @(posedge clk or posedge reset)
	begin
	   if (reset)
	       cnt <= 0;
	   else if (cnt >= max)
	   begin
		   cnt <= 0;
		   t <= ~t;
	   end
	   else
		   cnt <= cnt + 1;
	end

	
	always@(posedge t or posedge reset)
	begin
		if (reset)
		begin
		  init_stuff;
		end
        else 
        begin
			left <= left - 1;
			if (left == 1)
			begin
				if (wt)
				begin
					music <= {music[LEN-8:0], music[LEN:LEN-7]};
                    delay <= {delay[LEN-8:0], delay[LEN:LEN-7]};
                    node <= music[LEN:LEN-7];
                    left <= delay[LEN:LEN-7];
					max <= 1724138;
					wt <= 0;
				end
				else
				begin
					node <= 0;
					left <= 1;
					max <= 250000;
					wt <= 1;
				end
			end
		  end
	    end
endmodule

module music1(
	input clk,
	input reset,
	output speaker
);
    parameter LEN = 1871;
	reg [LEN:0] music;
	reg [LEN:0] delay;
	
	reg [31:0] max;
	reg [31:0] cnt;
	reg t;
	reg [7:0] left=0;
	reg wt = 0;
	reg [7:0] node;
	
	wave w(clk, node, speaker);
	
	task init_stuff;
	begin
	    left <= 1;
        wt <= 0;
        node <= 0;
        music <= 1872'h55358585a5a506853555358585a5a5068555358585a5a506853555358585a58555358585a5a506853555358585a5a506a555358585a5a506853555358585a58555358585a5a506853555358585a5a506a555358585a5a506853555358585a585160685555585a55585355585160685555585a55585160685555585a555853555853585151535153515a43585a5a585555585a50636a506853585a5a5855555a5853606003585a5a585555585a50636a5068575557585757585003585a5a585555585a50636a506853585a5a5855555a5853606003585a5a585555585a50636a506857555758575758500;
        delay <= 1872'h0404080808080808080404080808080810040408080808080808040408080820040408080808080808040408080808081004040808080808080804040808082004040808080808080804040808080808100404080808080808080404080808200404040404040404080808080404040404040404200404040404040404080808080c040c040404040404040404080404040404040404080404040408040404040404100404040408040404040404040408080810080404040c04040404080404040404040404080404040408040404040404100404040408040404040404040408080810080404081008;
	end
	endtask
	
	initial
	begin
	   init_stuff;
	end
	
	always @(posedge clk or posedge reset)
	begin
	   if (reset)
	       cnt <= 0;
	   else if (cnt >= max)
	   begin
		   cnt <= 0;
		   t <= ~t;
	   end
	   else
		   cnt <= cnt + 1;
	end

	
	always@(posedge t or posedge reset)
	begin
		if (reset)
		begin
		  init_stuff;
		end
        else 
        begin
			left <= left - 1;
			if (left == 1)
			begin
				if (wt)
				begin
					music <= {music[LEN-8:0],music[LEN:LEN-7]};
                    delay <= {delay[LEN-8:0],delay[LEN:LEN-7]};
                    node <= music[LEN:LEN-7];
                    left <= delay[LEN:LEN-7];
					max <= 1724138;
					wt <= 0;
				end
				else
				begin
					node <= 0;
					left <= 1;
					max <= 250000;
					wt <= 1;
				end
			end
		  end
	    end
endmodule

module music5(
	input clk,
	input reset,
	output speaker
);
    parameter LEN = 2983;
	reg [LEN:0] music;
	reg [LEN:0] delay;
	
	reg [31:0] max;
	reg [31:0] cnt;
	reg t;
	reg [7:0] left=0;
	reg wt = 0;
	reg [7:0] node;
	
	wave w(clk, node, speaker);
	
	task init_stuff;
	begin
	    left <= 1;
        wt <= 0;
        node <= 0;
        music <= 'h5405542554554525540554255494a4055405542554554525540554255494a4055405542554554525540554255494a405540554255455452554055425547494a40554442505a49454740454a344547494745474940554442505a49454740454a3445474947454009394a4945494a494540574440473430494a49454549405050574440473430494a4945494a494540574440473430494a4945405a4947400245474245474454525052454749454444555750524547424547400945400549474050500a49474044373044474050054745494947494947494947494059474547474547474547494a4942505a49494947494947494947494059474547474547405050514000400b394947494947494947494059474547474547474547494a4942505a494949474949474949474940594745474745474050594547454045324535444245304532494547454045324535444245304532494547454045324535444245304532494a494540453245354442453042495557555;
        delay <= 'h04040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040e01020102080808040808080404040808040404080808080408080804080808040404080804040408081202080404040c0404040c0101010101010a040404080404080c0101010101010a0404040c0404040c0101010101010a0404040c080808080804080808080804060208040808080808040404080408080808080404140404041c081004040818010101010101020808080804040408040408040404040404040404040804040804040808010101040404080404080404040404040404040408080404040404040c040404080404080404040404040404040408040408040408080101010404040804040804040404040404040404080814040404080404040404040404040404040404080404040404040404040404040404080404040404040404040404040404080404040404040404080404040404;
        end
	endtask
	
	initial
	begin
	   init_stuff;
	end
	
	always @(posedge clk or posedge reset)
	begin
	   if (reset)
	       cnt <= 0;
	   else if (cnt >= max)
	   begin
		   cnt <= 0;
		   t <= ~t;
	   end
	   else
		   cnt <= cnt + 1;
	end

	
	always@(posedge t or posedge reset)
	begin
		if (reset)
		begin
		  init_stuff;
		end
        else 
        begin
			left <= left - 1;
			if (left == 1)
			begin
				if (wt)
				begin
					music <= {music[LEN-8:0],music[LEN:LEN-7]};
                    delay <= {delay[LEN-8:0],delay[LEN:LEN-7]};
                    node <= music[LEN:LEN-7];
                    left <= delay[LEN:LEN-7];
					max <= 1000000;
					wt <= 0;
				end
				else
				begin
					node <= 0;
					left <= 1;
					max <= 250000;
					wt <= 1;
				end
			end
		  end
	    end
endmodule

//module music4(
//	input clk,
//	input reset,
//	output speaker
//);
//    parameter LEN = 3063;
//	reg [LEN:0] music;
//	reg [LEN:0] delay;
	
//	reg [31:0] max;
//	reg [31:0] cnt;
//	reg t;
//	reg [7:0] left=0;
//	reg wt = 0;
//	reg [7:0] node;
	
//	wave w(clk, node, speaker);
	
//	task init_stuff;
//	begin
//	    left <= 1;
//        wt <= 0;
//        node <= 0;
//        music <= 'h00757575007555454555754525000525450574000094b405749405749405050074740574940574940505b4b40075757500755545455575452500052545057474947474947405000594b400749400b47400759575004555755545259474549474450574947474947405002594b4007494b4050075750000755545052545004555006575000000957545257494059405250500750525050575052505550525050575052505750525050575052505550525050575052505750575757505250555052505057505250575052505057505250555052505057505250500757575007555454555754525000525754555254505257494547495007500007595750045557555452594745494754555254505257485352505252434935595009575b500265575950095759500b5759516266676000075750000755545052545004555006575000000957545257494059405250500057575000075554505254500455500657500000095754525749405940525050000957545257494050505940525050000;
//        delay <= 'h08040408040202040202040404040404040404041010100804040804040408040808080404080404040804100804040804020204020204040404040404040402020402020404080402020202020204040804040408020204020204040804040404040202040202040408040202020204040404020202020808040402020401010401050404040402020c0404040402020c08040404020204040404040404020204040404040404020204040404040404020204040404040404040404040404040402020404040404040402020404040404040402020404040408040408040202040202040404040404040404040404040404040203040e010804040408020204020204040804040404040404040404040404040404040404040404040404040202020202020202020202020202020204020202020808040402020401010401050404040402020c0404040402020c0804020202020808040402020401010401050404040402020c0404040402020c08040402020c04041004040404020a0410;
//    end
//	endtask
	
//	initial
//	begin
//	   init_stuff;
//	end
	
//	always @(posedge clk or posedge reset)
//	begin
//	   if (reset)
//	       cnt <= 0;
//	   else if (cnt >= max)
//	   begin
//		   cnt <= 0;
//		   t <= ~t;
//	   end
//	   else
//		   cnt <= cnt + 1;
//	end

	
//	always@(posedge t or posedge reset)
//	begin
//		if (reset)
//		begin
//		  init_stuff;
//		end
//        else 
//        begin
//			left <= left - 1;
//			if (left == 1)
//			begin
//				if (wt)
//				begin
//					music <= {music[LEN-8:0],music[LEN:LEN-7]};
//                    delay <= {delay[LEN-8:0],delay[LEN:LEN-7]};
//                    node <= music[LEN:LEN-7];
//                    left <= delay[LEN:LEN-7];
//					max <= 1724138;
//					wt <= 0;
//				end
//				else
//				begin
//					node <= 0;
//					left <= 1;
//					max <= 250000;
//					wt <= 1;
//				end
//			end
//		  end
//	    end
//endmodule