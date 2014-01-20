%Plot creator

b = [804
806
820
850
860
900
920
940
1000];

T1 = [18
50
30
5
230
160
1100
700
55];

T2 = [21
25
110
60
460
2090
40
170
160];

plot(b,T1,'k-o');
hold on
plot(b,T2,'b-.o');
hold off
xlabel('b');
ylabel('Settling time');
title('Time steps required for settling of system');
legend('Initial starting point (0,0)','Initial starting point (0.1,0)')
