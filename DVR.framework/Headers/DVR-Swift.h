// Generated by Apple Swift version 2.3 (swiftlang-800.10.13 clang-800.0.42.1)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if defined(__has_feature) && __has_feature(modules)
@import Foundation;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"

@interface NSHTTPURLResponse (SWIFT_EXTENSION(DVR))
@property (nonatomic, readonly, copy) NSDictionary<NSString *, id> * _Nonnull dictionary;
@end

@class NSObject;

@interface NSMutableURLRequest (SWIFT_EXTENSION(DVR))
- (void)appendHeaders:(NSDictionary * _Nonnull)headers;
@end


@interface NSMutableURLRequest (SWIFT_EXTENSION(DVR))
- (nonnull instancetype)initWithDictionary:(NSDictionary<NSString *, id> * _Nonnull)dictionary;
@end


@interface NSURLRequest (SWIFT_EXTENSION(DVR))
@end

@class NSData;

@interface NSURLRequest (SWIFT_EXTENSION(DVR))
- (NSURLRequest * _Nonnull)requestByAppendingHeaders:(NSDictionary * _Nonnull)headers;
- (NSURLRequest * _Nonnull)requestWithBody:(NSData * _Nonnull)body;
@end


@interface NSURLRequest (SWIFT_EXTENSION(DVR))
@property (nonatomic, readonly, copy) NSDictionary<NSString *, id> * _Nonnull dictionary;
@end


@interface NSURLResponse (SWIFT_EXTENSION(DVR))
@property (nonatomic, readonly, copy) NSDictionary<NSString *, id> * _Nonnull dictionary;
@end

@protocol NSURLSessionDelegate;
@class NSBundle;
@class NSURLSessionDataTask;
@class NSError;
@class NSURLSessionDownloadTask;
@class NSURL;
@class NSURLSessionUploadTask;

SWIFT_CLASS("_TtC3DVR7Session")
@interface Session : NSURLSession
@property (nonatomic, copy) NSString * _Nonnull outputDirectory;
@property (nonatomic, readonly, copy) NSString * _Nonnull cassetteName;
@property (nonatomic, readonly, strong) NSURLSession * _Nonnull backingSession;
@property (nonatomic) BOOL recordingEnabled;
@property (nonatomic, readonly, strong) id <NSURLSessionDelegate> _Nullable delegate;
- (nonnull instancetype)initWithOutputDirectory:(NSString * _Nonnull)outputDirectory cassetteName:(NSString * _Nonnull)cassetteName testBundle:(NSBundle * _Nonnull)testBundle backingSession:(NSURLSession * _Nonnull)backingSession OBJC_DESIGNATED_INITIALIZER;
- (NSURLSessionDataTask * _Nonnull)dataTaskWithRequest:(NSURLRequest * _Nonnull)request;
- (NSURLSessionDataTask * _Nonnull)dataTaskWithRequest:(NSURLRequest * _Nonnull)request completionHandler:(void (^ _Nonnull)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler;
- (NSURLSessionDownloadTask * _Nonnull)downloadTaskWithRequest:(NSURLRequest * _Nonnull)request;
- (NSURLSessionDownloadTask * _Nonnull)downloadTaskWithRequest:(NSURLRequest * _Nonnull)request completionHandler:(void (^ _Nonnull)(NSURL * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler;
- (NSURLSessionUploadTask * _Nonnull)uploadTaskWithRequest:(NSURLRequest * _Nonnull)request fromData:(NSData * _Nonnull)bodyData;
- (NSURLSessionUploadTask * _Nonnull)uploadTaskWithRequest:(NSURLRequest * _Nonnull)request fromData:(NSData * _Nullable)bodyData completionHandler:(void (^ _Nonnull)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler;
- (NSURLSessionUploadTask * _Nonnull)uploadTaskWithRequest:(NSURLRequest * _Nonnull)request fromFile:(NSURL * _Nonnull)fileURL;
- (NSURLSessionUploadTask * _Nonnull)uploadTaskWithRequest:(NSURLRequest * _Nonnull)request fromFile:(NSURL * _Nonnull)fileURL completionHandler:(void (^ _Nonnull)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler;
- (void)invalidateAndCancel;

/// You don’t need to call this method if you're only recoding one request.
- (void)beginRecording;

/// This only needs to be called if you call beginRecording. completion will be called on the main queue after the completion block of the last task is called. completion is useful for fulfilling an expectation you setup before calling beginRecording.
- (void)endRecording:(void (^ _Nullable)(void))completion;
@end


SWIFT_CLASS("_TtC3DVR15SessionDataTask")
@interface SessionDataTask : NSURLSessionDataTask
@property (nonatomic, weak) Session * _Null_unspecified session;
@property (nonatomic, readonly, strong) NSURLRequest * _Nonnull request;
@property (nonatomic, readonly, copy) void (^ _Nullable completion)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable);
@property (nonatomic, readonly, strong) NSURLResponse * _Nullable response;
- (nonnull instancetype)initWithSession:(Session * _Nonnull)session request:(NSURLRequest * _Nonnull)request completion:(void (^ _Nullable)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion OBJC_DESIGNATED_INITIALIZER;
- (void)cancel;
- (void)resume;
@end


SWIFT_CLASS("_TtC3DVR19SessionDownloadTask")
@interface SessionDownloadTask : NSURLSessionDownloadTask
@property (nonatomic, weak) Session * _Null_unspecified session;
@property (nonatomic, readonly, strong) NSURLRequest * _Nonnull request;
@property (nonatomic, readonly, copy) void (^ _Nullable completion)(NSURL * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable);
- (nonnull instancetype)initWithSession:(Session * _Nonnull)session request:(NSURLRequest * _Nonnull)request completion:(void (^ _Nullable)(NSURL * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion OBJC_DESIGNATED_INITIALIZER;
- (void)cancel;
- (void)resume;
@end


SWIFT_CLASS("_TtC3DVR17SessionUploadTask")
@interface SessionUploadTask : NSURLSessionUploadTask
@property (nonatomic, weak) Session * _Null_unspecified session;
@property (nonatomic, readonly, strong) NSURLRequest * _Nonnull request;
@property (nonatomic, readonly, copy) void (^ _Nullable completion)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable);
@property (nonatomic, readonly, strong) SessionDataTask * _Nonnull dataTask;
- (nonnull instancetype)initWithSession:(Session * _Nonnull)session request:(NSURLRequest * _Nonnull)request completion:(void (^ _Nullable)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion OBJC_DESIGNATED_INITIALIZER;
- (void)cancel;
- (void)resume;
@end

@class NSCoder;

SWIFT_CLASS("_TtC3DVR15URLHTTPResponse")
@interface URLHTTPResponse : NSHTTPURLResponse
@property (nonatomic, strong) NSURL * _Nullable URL;
@property (nonatomic) NSInteger statusCode;
@property (nonatomic, copy) NSDictionary * _Nonnull allHeaderFields;
- (nullable instancetype)initWithURL:(NSURL * _Nonnull)url statusCode:(NSInteger)statusCode HTTPVersion:(NSString * _Nullable)HTTPVersion headerFields:(NSDictionary<NSString *, NSString *> * _Nullable)headerFields OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithURL:(NSURL * _Nonnull)URL MIMEType:(NSString * _Nullable)MIMEType expectedContentLength:(NSInteger)length textEncodingName:(NSString * _Nullable)name OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface URLHTTPResponse (SWIFT_EXTENSION(DVR))
- (nonnull instancetype)initWithDictionary:(NSDictionary<NSString *, id> * _Nonnull)dictionary;
@end


SWIFT_CLASS("_TtC3DVR11URLResponse")
@interface URLResponse : NSURLResponse
@property (nonatomic, strong) NSURL * _Nullable URL;
- (nonnull instancetype)initWithURL:(NSURL * _Nonnull)URL MIMEType:(NSString * _Nullable)MIMEType expectedContentLength:(NSInteger)length textEncodingName:(NSString * _Nullable)name OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface URLResponse (SWIFT_EXTENSION(DVR))
- (nonnull instancetype)initWithDictionary:(NSDictionary<NSString *, id> * _Nonnull)dictionary;
@end

#pragma clang diagnostic pop