friend(ahmed, samy).
friend(ahmed, fouad).
friend(samy, mohammed).
friend(samy, said).
friend(samy, omar).
friend(samy, abdullah).
friend(fouad, abdullah).
friend(abdullah, khaled).
friend(abdullah, ibrahim).
friend(abdullah, omar).
friend(mostafa, marwan).
friend(marwan, hassan).
friend(hassan, ali).

friend(hend, aisha).
friend(hend, mariam).
friend(hend, khadija).
friend(huda, mariam).
friend(huda, aisha).
friend(huda, lamia).
friend(mariam, hagar).
friend(mariam, zainab).
friend(aisha, zainab).
friend(lamia, zainab).
friend(zainab, rokaya).
friend(zainab, eman).
friend(eman, laila).

% Q1

is_friend(A, B):-  friend(A, B); friend(B, A).

% _____________________________________________________________________________
% Q2

friendList(Person, InvertedL) :-
    friendListInvert(Person, L),
    invertlist(L, InvertedL),!.

friendListInvert(Person, L) :-
friendListInvert(Person, [], L).

friendListInvert(Person, Temp, L) :-
is_friend(Person, Friend), 
\+ is_member(Friend, Temp),
friendListInvert(Person, [Friend|Temp], L).
friendListInvert(_, L, L).

% _____________________________________________________________________________
% Q3

% a predicate to check if an element is a member of a list
is_member(X, [X|_]).
is_member(X, [_|Tail]):-
is_member(X, Tail).

friendListCount(Person, Count) :-
friendListCount(Person, [], 0, Count).

friendListCount(Person, Visited, Temp, Count) :-
friend(Person, Friend),
\+ is_member(Friend, Visited),
NewTemp is Temp + 1,
NewVisited = [Friend|Visited],

friendListCount(Person, NewVisited, NewTemp, Count),!.    
friendListCount(_, _, Count, Count).

% _____________________________________________________________________________
% Q4

peopleYouMayKnow(Person, Friend_of_Friend):-
is_friend(Person, Friend),
is_friend(Friend, Friend_of_Friend),
\+ Friend_of_Friend = Person.

% _____________________________________________________________________________
% Q5
%to concat two lists
concat([],L,L).
concat([X1|L1],L2,[X1|L3]) :- 
    concat(L1,L2,L3).
%to concat two lists

%Length of list
list_length(L,R) :- 
    list_length(L,0,R) .

list_length([],R,R) .
list_length( [_|L],Count ,R) :-
  Count1 is Count+1 ,
  list_length(L,Count1,R).



%exclude the person and friends of the person
exclude(_, [], []).

exclude(Person, [H|T], Result) :-
    (Person = H;
    is_friend(Person, H)), 
    exclude(Person, T, Result).

exclude(Person, [H|T], [H|Result]) :-
    H \= Person,
    exclude(Person, T, Result).
%exclude the person and friends of the person


%Returns a list of friends of the person friends

allfriends(Person, N,Person_friends, AllFriends) :-
    allfriends(Person, N, Person_friends, [], AllFriends).

allfriends(_, _, [], AllFriends, AllFriends).

allfriends(Person, N, [F|Fs], TempList, AllFriends) :-
    friendListCount(Person, Count),
    Count >= N,
    friendList(F, F_Friends),
    concat(F_Friends, TempList, ResList),
    allfriends(Person, N, Fs, ResList, AllFriends).

allfriends(Person, N, [_|Fs], TempList, AllFriends) :-
    allfriends(Person, N, Fs, TempList, AllFriends).
%Returns a list of friends of the person friends

%finds mutuals

mutual(_, [], _).

mutual(Person_friends,N ,[H|_], SuggestedF) :-
    is_mutual_friend(Person_friends,N, H),
    SuggestedF = H.

mutual(Person_friends,N, [_|T], SuggestedF) :-
    mutual(Person_friends,N, T, SuggestedF).

is_mutual_friend([F|Fs], N, MutualFriend) :-
    is_mutual_friend([F|Fs], 0, N, MutualFriend).

is_mutual_friend([],_,_, _).

is_mutual_friend([F|Fs],Temp,N, MutualFriend) :-
    friend(F, MutualFriend),
    NewTemp is Temp+1,
     (NewTemp =:= N ,
      MutualFriend = MutualFriend;
    is_mutual_friend(Fs,NewTemp,N, MutualFriend)).
    
    
%main
%AllFriends2 is without the person and his direct friends
peopleYouMayKnow(Person, N, SuggestedF):-
    friendList(Person, Person_friends),
    allfriends(Person, N,Person_friends, AllFriends),
    exclude(Person,AllFriends,AllFriends2),
    mutual(Person_friends,N, AllFriends2, SuggestedF),
    !.
    
% _____________________________________________________________________________
% Q6

% This is a predicate to invert a list
invertlist([H|T],L):-
    invertlist([H|T],[],L).
invertlist([H|T],TempList,L):-
    invertlist(T,[H|TempList],L).
invertlist( _, L, L).


% This is the main predicate to get the people a person may know
peopleYouMayKnowListInvert(Person, L) :-
peopleYouMayKnowListInvert(Person, [], L).

peopleYouMayKnowListInvert(Person, TempList, L) :-
is_friend(Person, Friend), 
is_friend(Friend, NewFriend),
NewFriend \== Person,
\+ is_member(NewFriend, TempList),
\+ is_friend(Person, NewFriend),
peopleYouMayKnowListInvert(Person, [NewFriend|TempList], L).
peopleYouMayKnowListInvert(_, L, L).


% This is the called predicate it calls the main predicate and the invert predicate
% To invert the result list
peopleYouMayKnowList(Person, InvertedL) :-
    peopleYouMayKnowListInvert(Person, L),
    invertlist(L, InvertedL),!.


% _____________________________________________________________________________
% Bonus 

peopleYouMayKnow_indirect(Person, Third_Friend):-
is_friend(Person, Friend),
is_friend(Friend, Friend_of_Friend),
is_friend(Friend_of_Friend, Third_Friend),
\+ is_friend(Person, Third_Friend),
\+ is_friend(Friend, Third_Friend),
\+ Third_Friend = Person,
\+ Third_Friend = Friend,
\+ Friend_of_Friend = Person.