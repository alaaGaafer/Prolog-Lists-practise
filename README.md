# Prolog-SocialNetworkFriendSuggestions
Description:
The SocialNetworkFriendSuggestions code provides a set of predicates to analyze friend connections in a social network and suggest potential friends to individuals. It allows users to explore their immediate friends, count the number of friends they have, and discover friends of friends who could be potential connections.

The code includes the following predicates:

is_friend(A, B): Checks if individuals A and B are friends.

friendList(Person, InvertedL): Retrieves a list of friends of a given person, with the friends' names in inverted order.

friendListCount(Person, Count): Counts the number of friends a person has.

peopleYouMayKnow(Person, Friend_of_Friend): Suggests potential friends to a person by identifying friends of friends who are not directly connected to the person.

peopleYouMayKnow(Person, N, SuggestedF): Enhances the previous suggestion by allowing users to specify a minimum number (N) of mutual friends with the suggested friends.

peopleYouMayKnowList(Person, InvertedL): Similar to peopleYouMayKnow, but the list of suggested friends is inverted.

peopleYouMayKnow_indirect(Person, Third_Friend): Suggests potential friends who are not directly connected to a person but share a common friend.

Overall, the SocialNetworkFriendSuggestions code provides valuable functionality for analyzing friend connections and making friend recommendations within a social network.
