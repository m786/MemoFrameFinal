// Generated by Apple Swift version 3.1 (swiftlang-802.0.51 clang-802.0.41)
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
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
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
#if defined(__has_attribute) && __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if defined(__has_attribute) && __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if defined(__has_attribute) && __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
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
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import CoreGraphics;
@import Foundation;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"

@interface UIImage (SWIFT_EXTENSION(AlamofireImage))
/// Returns a new version of the image with the corners rounded to the specified radius.
/// \param radius The radius to use when rounding the new image.
///
/// \param divideRadiusByImageScale Whether to divide the radius by the image scale. Set to <code>true</code> when the
/// image has the same resolution for all screen scales such as @1x, @2x and
/// @3x (i.e. single image from web server). Set to <code>false</code> for images loaded
/// from an asset catalog with varying resolutions for each screen scale.
/// <code>false</code> by default.
///
///
/// returns:
/// A new image object.
- (UIImage * _Nonnull)af_imageRoundedWithCornerRadius:(CGFloat)radius divideRadiusByImageScale:(BOOL)divideRadiusByImageScale SWIFT_WARN_UNUSED_RESULT;
/// Returns a new version of the image rounded into a circle.
///
/// returns:
/// A new image object.
- (UIImage * _Nonnull)af_imageRoundedIntoCircle SWIFT_WARN_UNUSED_RESULT;
@end


@interface UIImage (SWIFT_EXTENSION(AlamofireImage))
/// Initializes and returns the image object with the specified data in a thread-safe manner.
/// It has been reported that there are thread-safety issues when initializing large amounts of images
/// simultaneously. In the event of these issues occurring, this method can be used in place of
/// the <code>init?(data:)</code> method.
/// \param data The data object containing the image data.
///
///
/// returns:
/// An initialized <code>UIImage</code> object, or <code>nil</code> if the method failed.
+ (UIImage * _Nullable)af_threadSafeImageWith:(NSData * _Nonnull)data SWIFT_WARN_UNUSED_RESULT;
/// Initializes and returns the image object with the specified data and scale in a thread-safe manner.
/// It has been reported that there are thread-safety issues when initializing large amounts of images
/// simultaneously. In the event of these issues occurring, this method can be used in place of
/// the <code>init?(data:scale:)</code> method.
/// \param data The data object containing the image data.
///
/// \param scale The scale factor to assume when interpreting the image data. Applying a scale factor of 1.0
/// results in an image whose size matches the pixel-based dimensions of the image. Applying a
/// different scale factor changes the size of the image as reported by the size property.
///
///
/// returns:
/// An initialized <code>UIImage</code> object, or <code>nil</code> if the method failed.
+ (UIImage * _Nullable)af_threadSafeImageWith:(NSData * _Nonnull)data scale:(CGFloat)scale SWIFT_WARN_UNUSED_RESULT;
@end


@interface UIImage (SWIFT_EXTENSION(AlamofireImage))
/// Returns a new version of the image scaled to the specified size.
/// \param size The size to use when scaling the new image.
///
///
/// returns:
/// A new image object.
- (UIImage * _Nonnull)af_imageScaledTo:(CGSize)size SWIFT_WARN_UNUSED_RESULT;
/// Returns a new version of the image scaled from the center while maintaining the aspect ratio to fit within
/// a specified size.
/// The resulting image contains an alpha component used to pad the width or height with the necessary transparent
/// pixels to fit the specified size. In high performance critical situations, this may not be the optimal approach.
/// To maintain an opaque image, you could compute the <code>scaledSize</code> manually, then use the <code>af_imageScaledToSize</code>
/// method in conjunction with a <code>.Center</code> content mode to achieve the same visual result.
/// \param size The size to use when scaling the new image.
///
///
/// returns:
/// A new image object.
- (UIImage * _Nonnull)af_imageAspectScaledToFit:(CGSize)size SWIFT_WARN_UNUSED_RESULT;
/// Returns a new version of the image scaled from the center while maintaining the aspect ratio to fill a
/// specified size. Any pixels that fall outside the specified size are clipped.
/// \param size The size to use when scaling the new image.
///
///
/// returns:
/// A new image object.
- (UIImage * _Nonnull)af_imageAspectScaledToFill:(CGSize)size SWIFT_WARN_UNUSED_RESULT;
@end


@interface UIImage (SWIFT_EXTENSION(AlamofireImage))
/// Returns whether the image contains an alpha component.
@property (nonatomic, readonly) BOOL af_containsAlphaComponent;
/// Returns whether the image is opaque.
@property (nonatomic, readonly) BOOL af_isOpaque;
@end


@interface UIImage (SWIFT_EXTENSION(AlamofireImage))
/// Returns whether the image is inflated.
@property (nonatomic) BOOL af_inflated;
/// Inflates the underlying compressed image data to be backed by an uncompressed bitmap representation.
/// Inflating compressed image formats (such as PNG or JPEG) can significantly improve drawing performance as it
/// allows a bitmap representation to be constructed in the background rather than on the main thread.
- (void)af_inflate;
@end

#pragma clang diagnostic pop
