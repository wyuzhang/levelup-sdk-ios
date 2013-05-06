/**
 Parses a "Web Link" HTTP header: http://tools.ietf.org/html/rfc5988.

 These headers have the form:

 <http://example.com/TheBook/chapter1>; rel="previous"; title="previous chapter", <http://example.com/TheBook/chapter3>; rel="next"; title="next chapter",

 In this particular class, the `nextURL` method looks for a link that includes a link with a relation type of "next".
 For example:

 <http://example.com>; rel="next"
*/

@interface LUWebLinkParser : NSObject

- (id)initWithHeaderValue:(NSString *)headerValue;
- (NSURL *)nextURL;

@end
