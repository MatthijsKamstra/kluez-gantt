package const;

class Gantt {
	public static final TEST_0 = '
  section A section
    Completed task            :done,    des1, 2014-01-06,2014-01-08
    %% Active task               :active,  des2, 2014-01-09, 3d
    %% Future task               :         des3, after des2, 5d
    %% Future task2              :         des4, after des3, 5d
    %% Future task3              :        2d
';
	public static final TEST_1 = '
  section A section
     Completed task            :done,    des1, 2014-01-06,2014-01-08
     Active task               :active,  des2, 2014-01-09, 3d
     Future task               :         des3, after des2, 5d
     Future task2              :         des4, after des3, 5d
     Future task3              :        2d
';
	public static final TEST_2 = '
  section Duidelijk 5 day vs 7 days
     Maandag tot vrijdag            :2022-07-11,2022-07-15
     Maandag + 5 dagen            :2022-07-11, 5d
     Maandag + 7 dagen            :2022-07-11, 7d
     Vrijdag tot dinsdag         :2022-07-15,2022-07-19
     Vrijdag + 5        :2022-07-15,5d
     Vrijdag + 10        :2022-07-15,10d

';
	public static final TEST_TOTAL = '
  section A section
    Completed task            :done,    des1, 2014-01-06,2014-01-08
    Active task               :active,  des2, 2014-01-09, 3d
    Future task               :         des3, after des2, 5d
    Future task2              :         des4, after des3, 5d

    section Critical tasks
    Completed task in the critical line :crit, done, 2014-01-06,24h
    Implement parser and jison          :crit, done, after des1, 2d
    Create tests for parser             :crit, active, 3d
    Future task in critical line        :crit, 5d
    Create tests for renderer           :2d
    Add to mermaid                      :1d
    Functionality added                 :milestone, 2014-01-25, 0d

    section Documentation
    Describe gantt syntax               :active, a1, after des1, 3d
    Add gantt diagram to demo page      :after a1  , 20h
    Add another diagram to demo page    :doc1, after a1  , 48h

    section Last section
    Describe gantt syntax               :after doc1, 3d
    Add gantt diagram to demo page      :20h
    Add another diagram to demo page    :48h
';
}
