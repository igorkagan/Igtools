function s4 = ig_intersect3(s1,s2,s3)
%IG_INTERSECT3		- intersect between 3 sets
ss = intersect(s1,s2);
s4 = intersect(ss,s3);

