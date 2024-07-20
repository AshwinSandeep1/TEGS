clear
clc
close all

h=100; %linspace(1,100,100); %hours of storage
p=10*1e6; %Power output in W
Q_per=0.03;% (0.0001:0.0001:0.05);%Heat loss per day in fraction
Th=2400; %Max storage Temperature (nominal) [C]
Tc=Th-500; %Min storage Temperature (nominal) [C]
ChargeMultiplier=1;
eta_dis=0.5; %alinas code, average over 1900-2400C
eta_ch=0.99; %Electrical to thermal efficiency fo heater
% d=1;
ff_dis=10; %Discharge flowrate factor
ff_ch=1; %Charge flowrate factor
SF = 1.83; %Scaling Factor multiplied with CPP to match values given by Prof. Henry

%Storage tank
mp_C=1;             %mass fraction carbon (Fe balance)
rho_C=1700;         %From alibaba (XRD Graphite quote)
rho=rho_C;          %kg/m3 density of medium
k_C=30;             %Graphite thermal conductivity [W/m-K] (at ~1750C)
k_ALII=1.5;         %ALII Refractory Cement thermal conductivity [W/m-K]
k_Cfelt=0.3;        %Graphite Felt thermal conductivity [W/m-K] (at~1750C) values vary depending on source (could be as high as 0.6)
k_ASO=0.2;          %Alumina Silica insulation thermal conductivity [W/m-K]
k_FG=0.05;          %Fiberglass insulation thermal conductivity [W/m-K]
c_C=2000;           %Specific heat of carbon at 2000C [J/kg*K]
c=c_C;              %J/(kg*K) specific heat

%Temperature limits
T_ALII=1700;    %max ALII temp C
T_ASO=1350;     %max rated temp C
T_FG=540;       %max rated temp C
T_WC=80;        %Water cooled bottom temp

Ed=c*(Th-Tc)*rho/1000000/3600; %Thermal energy capacity (MWh/m3)

%Mechanical limits
St_C=25e6; %designed tensile stress of graphite in Pa (FS included here of 2)
Sc_rig_felt=1e6;

%Cost Inputs
Cg_kg=0.5; %Graphite cost per kg [$/kg] (from alibaba quote for ~1 m3 blocks)
Cg=Cg_kg*rho_C; %Graphite cost per m3 [$/m3]
Cfelt=7000; % Felt cost per m3 [$/m3] (based on ceramaterials and alibaba typical ($75/kg, 100kg/m3 density))
Crig2=0.25/1.63871e-5; %rigid graphite felt cost per cubic meter ($0.25/in3) Carbon Composites Inc.
ALII=5950; %Refractory cement cost per cubic meter
ASO=400; %Al2O3-SiO2 blanket cost per cubic meter alibaba quote
FG=84.8; %Fiberglass blanket cost per cubic meter
Con=200; %Concrete cost per cubic meter

CTin=102000; %Tin cost per cubic meter ($17/kg*6000kg/m3)

CMed=mp_C*Cg_kg;  % storage medium cost per kg

%storage block Geometry outputs
e_e=p*h;                  %Wh-e
e=e_e*(1./eta_dis);       %Wh-t energy stored in block                     %verify this setup
m=e*3600./(c.*(Th-Tc));   %mass of med required
V= m/rho;                 %volume of storage medium required
Ar=2;                     %Aspect Ratio (D/H) Need to check optimum as variables change 1.69
Q_side=Q_per./(1+Ar/2);   %Heat loss out of sides (corrected for top/bot heat loss)
D_gr=(4*Ar*V/pi).^(1/3);  %ID of block m
H=D_gr./Ar;               %Height of block [m]D1=Ar*H1;

D=1.1265*D_gr;               %ID incl. Sn

%Mechanical Calculations
P_b=rho*9.81*H; %pressure at bottom of tank
B_ALII=8; %fixed because excessively high (thermal conductivity limited by ASO) Sc_ALII./P_b; %ratio of area in base blocks that can be empty ALII
D_C=D+(2*0.5)*(((rho*9.81*H).*(D./2))/St_C); %OD of C layer: ID+t--> t=P*r/St 2 for D, 0.5 for cone
SF_felt=Sc_rig_felt./P_b;

%Thermal Calculations
Q=e.*Q_side/(24); %Heat loss in Watts
q_flux=Q./(pi.*D.*H); %heat flux allowed through surfaces of tanks
T_Cfelt=Th-Q.*(log(D_C./D))./(2*pi*H*k_C); %graphite temperature drop
a_Cfelt=(T_Cfelt-T_ASO).*(2*pi*H)*k_Cfelt./Q; %parameter for cylindrical conduction
D_Cfelt=D_C.*exp(a_Cfelt); %OD of ALII layer
a_ASO=(T_ASO-T_FG)*(2*pi*H)*k_ASO./Q; %parameter for cylindrical conduction
D_ASO=D_Cfelt.*exp(a_ASO); %OD of ASO layer
D_FG=D_ASO*1.01; %fixed value of fiberglass thickness (instead of solving convection problem)
H_B_C=(T_Cfelt-T_ALII).*(k_Cfelt)./q_flux; %height of felt required to match heat loss and temp constraints
H_B_ALII=(T_ALII-T_WC).*(k_ALII./B_ALII)./q_flux; %height of cinder blocks required to match heat loss and temp constraints

%storage tank material volumes
V_C=pi.*(D_C.^2/4-D.^2/4).*H+pi*D_gr.^2/4.*H+pi*D.^2/4.*2*.05;  %walls,(2"thk top and bottom)
V_Crig = pi*D.^2/4.*H_B_C./SF_felt; %volume of rigid felt
V_ALII=pi*D.^2/4.*H_B_ALII/2; %ALII blocks under graphite felt
V_Cfelt=pi*(D_Cfelt.^2/4-D_C.^2/4).*H.*(Ar./4+1)+...
   (pi*D.^2/4.*H_B_C-pi*D.^2/4.*H_B_C./SF_felt);  %walls and roof
V_ASO=pi*(D_ASO.^2/4-D_Cfelt.^2/4).*H.*(Ar./4+1);  %walls and roof
V_FG=pi*(D_FG.^2/4-D_ASO.^2/4).*H.*(Ar./4+1);     %walls and roof
V_Con=pi*D.^2/4.*(0.2); %concrete volume in base

%p_t=p./eta; %Heater power input (W)

%Storage tanks cost
%Cost_fluid=m*CMed;
Cost_fluid=0.016*V*CTin;
%Cost_graphite=2*Cg*V_C;
Cost_graphite=Cg*V_C;
Cost_graphite_felt=Cfelt.*V_Cfelt;
Cost_graphite_rig=Crig2.*V_Crig;
Cost_ALII=1.5*ALII*V_ALII;
Cost_alumina_blanket=1.5*ASO*V_ASO;
Cost_fiberglass_blanket=1.5*FG*V_FG;
Cost_concrete=2*Con*V_Con;
Cost_cooling=0.08.*q_flux.*pi.*D.^2/4; %8cents/W
Cost_tank=Cost_fluid+Cost_graphite+Cost_graphite_felt+Cost_graphite_rig+Cost_ALII+...
    Cost_alumina_blanket+Cost_fiberglass_blanket+Cost_concrete+Cost_cooling;

Cost_Construction=0.3.*3.39.*(0.8./Ed).*(600e3./.45).*((e./(Ed/0.8))/(600e6./.45)).^(0.7)+...
    (1.15./Ed).*(e./2e9).*50000; %scaled from Glatzmaier and Medrano plus bolting time https://www.nrel.gov/docs/fy12osti/53066.pdf
Cost_N2_barrier=0.05*(e./1000); %$ from greg

%Heater Cost
p_t_charge_nom = p*ChargeMultiplier/(eta_dis*eta_ch);
p_t_charge_ext = p_t_charge_nom.*ff_ch;
Cost_Heater_elements=SF*18*11500*(p_t_charge_ext/200e6);      %Element cost (cost ~$18/m graphite store)
Cost_Heater_controller=SF*(p_t_charge_ext*5/1000);            %Controller Cost $5/kW thyristor controllers
Cost_Heater_pipes=SF*(103*10*555)*(p_t_charge_ext/200e6);     %C Pipe cost from graphite store
Cost_Heater_headers=SF*3*3*2700*(p_t_charge_ext/200e6);       %quote for custom headers
Cost_Heater_Cfelt=SF*2.4*Cfelt*(p_t_charge_ext/80e6);         %Graphite felt insulation cost
Cost_Heater_ASO=SF*2.6*ASO*(p_t_charge_ext/80e6);             %Al2O3-SiO2 insulation cost
Cost_Heater_FG=SF*1*FG*(p_t_charge_ext/80e6);                 %FG insulation cost
Cost_Heater=(Cost_Heater_elements+Cost_Heater_controller+Cost_Heater_pipes+Cost_Heater_Cfelt...
    +Cost_Heater_headers+Cost_Heater_ASO+Cost_Heater_FG); %$

%MPV Cost
C_cells=10000; %$/m2
p_t=p./eta_dis; %MPV power input (W)
T_MPV_out = Tc;
T_MPV_in_min = T_MPV_out+(Th-Tc)/ff_dis;
T_avg = (T_MPV_in_min+T_MPV_out)/2+273;
EParray = [1773 1823 1873 1923 1973 2023 2073 2123 2173 2223 2273 2323 2373 2423 2473 2523 2573 2623 2673; %deg K
    1.040 1.354 1.741 2.209 2.768 3.414 4.146 4.965 5.885 6.925 8.102 9.324 10.400 11.564 12.819 14.169 15.620 17.192 18.904]; %W/cm2
EP = interp1(EParray(1,:), EParray(2,:), T_avg).*10000; %W-e/m2 %Cell electrical power density

Cost_MPV_perWe=C_cells./EP; %$/W
Cost_MPV_cells=SF*p*Cost_MPV_perWe;
Cost_MPV_W_foil=SF*700.*4.*p./EP; %$700/m2 from alibaba
Cost_MPV_inverter=SF*(p.*.08);
Cost_MPV_cooling=SF*p.*(1-eta_dis)./eta_dis.*0.08; %coal cooling tower ($Russel air cooled water cooler $0.15/W)
Cost_MPV_pipes=SF*(103./(0.04.*EP)).*(p).*(0.5./eta_dis); %C Pipe cost from graphite store
Cost_MPV_headers=SF*9*3*2700*(p_t/200e6).*50000./EP;
Cost_MPV_Cfelt=SF*2.4*5*Cfelt*(p_t/80e6).*50000./EP; %Graphite felt insulation cost
Cost_MPV_ASO=SF*2.6*5*ASO*(p_t/80e6).*50000./EP; %Al2O3-SiO2 insulation cost
Cost_MPV_FG=SF*1*FG*5*(p_t/80e6).*50000./EP; %FG insulation cost
Cost_MPV=(Cost_MPV_cells+ Cost_MPV_W_foil+Cost_MPV_cooling+Cost_MPV_inverter+Cost_MPV_pipes...
    +Cost_MPV_Cfelt+Cost_MPV_headers+Cost_MPV_ASO+Cost_MPV_FG); %$

Cost_Controls=SF*6*(p_t./1000); %$ from greg
Cost_Pumps_pipes=SF*(2*2000*Cg+100*100*Cg)*(p_t./200e6)/rho_C; %2000kg pump and 100m of 100kg/m pipe

Cost_Pumps_pipes_dis=(SF*(2*2000*Cg+100*100*Cg)*(p_t./200e6)/rho_C)*ff_dis; %2000kg pump and 100m of 100kg/m pipe
Cost_Pumps_pipes_ch=(SF*(2*2000*Cg+100*100*Cg)*(p_t_charge_nom./200e6)/rho_C)*ff_ch; %2000kg pump and 100m of 100kg/m pipe


Cost_CPP_construction=SF*0.1.*((0.5./eta_dis).*(.18+.43).*(.45./6).*(0.8./Ed).*p.*(p./100e6).^0.7+44000*p./100e6).*50000./EP;  %CHK ERROR Glatzmier pipe, controls cost plus pipe assembly time

%Costs for techno-economics reporting
CPE=(Cost_tank+Cost_N2_barrier+Cost_Construction)./(e_e./1000); %$/kWh-e
CPP=(Cost_MPV+Cost_Heater+Cost_Pumps_pipes+Cost_Controls+Cost_CPP_construction)./p; %$/W
CPES = CPE+CPP./h.*1000;

%Costs for GenX
CPE_GenX=(Cost_tank+Cost_N2_barrier+Cost_Construction)./(e./1000) %$/kWh-th
CPP_dis_GenX=(Cost_MPV+Cost_Pumps_pipes_dis+Cost_Controls+Cost_CPP_construction)./p %$/W
CPP_ch_GenX=(Cost_Heater+Cost_Pumps_pipes_ch)./p_t_charge_nom %$/W

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Cost Breakdown

CPE_Medium = Cost_fluid./(e_e./1000);
CPE_TankMaterial = Cost_graphite./(e_e./1000);
CPE_GraphiteInsulation = (Cost_graphite_felt+Cost_graphite_rig)./(e_e./1000);
CPE_AluminaInsulation =  Cost_alumina_blanket./(e_e./1000);
CPE_FiberglassInsulation = Cost_fiberglass_blanket./(e_e./1000);
CPE_TankBase = (Cost_concrete+Cost_ALII)./(e_e./1000);
CPE_CoolingBase = Cost_cooling./(e_e./1000);
CPE_InertContainment = Cost_N2_barrier./(e_e./1000);
CPE_Construction = Cost_Construction./(e_e./1000);

%CPP_Heater= Cost_Heater./p
CPP_Heater = Cost_Heater./p_t_charge_nom;

CPP_Heater_elements=Cost_Heater_elements./p_t_charge_nom;      
CPP_Heater_controller=Cost_Heater_controller./p_t_charge_nom;            
CPP_Heater_grapite=(Cost_Heater_pipes+Cost_Heater_headers)./p_t_charge_nom;        
CPP_Heater_insulation=(Cost_Heater_Cfelt+Cost_Heater_ASO+Cost_Heater_FG)./p_t_charge_nom;
CPP_Pumps_pipes_ch = Cost_Pumps_pipes_ch./p_t_charge_nom;

CPP_Array = [CPP_Heater_elements;CPP_Heater_controller;CPP_Heater_grapite;CPP_Heater_insulation;CPP_Pumps_pipes_ch];

CPP_MPVCells= Cost_MPV_cells./p;
CPP_TungstenFoil = Cost_MPV_W_foil./p;
CPP_Inverter = Cost_MPV_inverter./p;
CPP_Cooling= Cost_MPV_cooling./p;
CPP_Graphite = (Cost_MPV_pipes+Cost_MPV_headers)./p;
CPP_Insulation = (Cost_MPV_Cfelt+Cost_MPV_ASO+Cost_MPV_FG)./p;
CPP_PumpsPiping= Cost_Pumps_pipes./p;
CPP_Construction = Cost_CPP_construction./p;
CPP_Controls = Cost_Controls./p;

CPP_Array = [CPP_MPVCells.*ones(1, length(Th));CPP_Inverter.*ones(1, length(Th));...
    CPP_Graphite.*ones(1, length(Th));CPP_TungstenFoil.*ones(1, length(Th));...
    CPP_Insulation.*ones(1, length(Th));CPP_Cooling.*ones(1, length(Th));...
    CPP_PumpsPiping.*ones(1, length(Th));CPP_Construction.*ones(1, length(Th));...
    CPP_Controls.*ones(1, length(Th))];

