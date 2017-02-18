Test1Score = Test1Hits / Test1Max * 100;
Test2Score = Test2Hits * 10;
Test3Score = Test3Hits * 100;
OverallScore = Test1Score + Test2Score + Test3Score;



hint format ["Limit reached.\n\nTime Attack Score: %1\n\nRange Score: %2\n\nOSOK Score: %3\n\nOverall: %4\n\nMin. To Pass: 300", Test1Score, Test2Score, Test3Score, OverallScore];
