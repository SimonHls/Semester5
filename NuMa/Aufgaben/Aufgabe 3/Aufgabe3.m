% Ideale Lösung laut Dozent (irgendwo hab ich mich n bisschen vertippt, Vorzeichen evtl.)
%Immer 4 signifikante Stellen und round to even

function Aufgabe3()
clc
% Matrix A herstellen
A = [50, -21, 91; -29, -59, 10; 110, 90, 81];
disp("Ursprungsmatrix:")
A0 = A %Kopie von A für später


% ====1. Spalte====

% Spalten-Pivotisierung: 1./3. Zeile Tauschen, damit größtes Element in 1.
% Position.
P1 = [0,0,1;0,1,0;1,0,0]; %Vertauschungsmatrix
disp("Vertauschtes A mit Vertauschungsmatrix:")
A = P1 *A

%2. Zeile eliminieren
format long;
disp("Eliminierungsfaktor 2. Zeile:")
q1 = A(2,1)/A(1,1)
disp("Eliminierungsfaktor von Hand gerundet (Aufgabenstellung):")
format short
q1 = -0.2636

%2. Zeile - 1. Zeile ausrechnen, in 2. Zeile speichern
disp("2. Zeile - 1. Zeile ausrechnen, in 1. Zeile speichern:")
A(2,:) = A(2,:) - q1 * A(1,:)

disp("  => Es kommt auf pos 2,1 nicht 0 raus, wegen Rundung.")
disp("Per Hand Runden und 0 genau machen (Aufgabenstellung)")

A(2,:) = [0, -35.28, 31.35]

%3. Zeile eliminieren wie oben
q2 = A(3,1)/A(1,1);
disp("Eliminierungsfaktor 3. Zeile gerundet:")
q2 = 0.4545 %per Hand gerundet
disp("3. Zeile - 1. Zeile ausrechnen, in 3. Zeile speichern:")
A(3,:) = A(3,:) - q2 * A(1,:)
% Round to even mit format long überprüfen
% Hier weider die Werte in der 3. Zeile runden
disp("per Hand gerundet:")
A(3,:)=[0,-60.90,54.19]

disp("==ERSTE ZEILE UND SPALTE IST FERTIG==")

% ====2. Spalte====

% Spalten-Pivotisierung (größtes Element in der Spalte finden): 2./3. Zeile
% vertauschen
disp("Spalten-Pivotisierung: 2. und 3. Zeile tauschen")
P2 = [1,0,0;0,0,1;0,1,0]; %Vertauschungsmatrix
A = P2 * A
% 3. Zeile eliminieren
q3 = A(3,2)/A(2,2);
disp("3. Zeile eliminieren (gerundet)")
q3 = 0.5793
disp("Nach eliminierung:")
A(3,:) = A(3,:) - q3 * A(2,:)
disp("gerundet:")
A(3,:) = [0,0,-0.04227]
disp("Obere Dreiecksmatrix U ist fertig: U = A")
U = A

%Alle tauschoperationen müssen auch bei A L nachgemacht werden
L =[1,0,0;q2,1,0;q1,q3,1]
P = P2*P1

%check
disp("CHECK:")
P* A0-L*U

disp("===TEIL B===")
% Teil B: Ax=b lösen
b = [89, -185, 449]'
bp = P*b;

% y berechnen durch Vorwärtssubstitution
y = zeros(3,1);
y(1) = bp(1);
y(2) = bp(2) - L(2,1)*y(1);
y(2) = -115.1; % per Hand gerundet
y(3) = bp(3) - L(3,1)*y(1) - L(3,2)*y(2);
y(3) = 0.03383 % per Hand gerundet

% x ausrechnen durch Rückwärtssubstitution
x = zeros(3,1);
x(3) = y(3)/U(3,3);
x(3) = -0.8003; % per Hand gerundet
x(2) = (y(2) - U(2,3)*x(3))/U(2,2);
x(2) = 1.178; % per Hand gerundet
x(1) = (y(1) - U(1,2) * x(2) - U(1,3) * x(3)) / U(1,1);
x(1) = 3.707 % per Hand gerundet

%Probe
A0*x - b

%Tatsächliche Lösung
xok = [4;1;-1];
A0*xok - b
