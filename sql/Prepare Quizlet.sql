

SELECT  *
FROM    ( SELECT  
			ROW_NUMBER() OVER ( order by Occurences desc ) AS RowNum, 
            (Lemma + '| ' + '*' + ltrim(rtrim(Bangla)) + '*' + char(13) +  
				Usage3 + char(13) + char(13) + 
				REPLACE(Translation,'&quot;', '''') + char(13) + char(13) + 
				Convert(nvarchar(6), Occurences) + ' times, ' + 
				[dbo].[GetLearntPercent](Root, Lemma)  + '% learnt' + char(13) +
				(case
					when root = '' then ''
					else 'Root: ' + Root + ' ' + IsNull(RootMeaning,'') 
				end) +  '~') as Content
			FROM [Quran].[dbo].[LemmaMeaningUsageAyah3]	a
			WHERE Bangla != ''
        ) AS RowConstrainedResult
WHERE   RowNum >= 1
    AND RowNum <= 100
ORDER BY RowNum


