import 'package:dartz/dartz.dart';
import 'package:tech_talk/core/data/responses/childrem_comment_response.dart';
import 'package:tech_talk/core/data/models/user_general_model.dart';
import 'package:tech_talk/core/data/responses/Verify_Otp_response.dart';
import 'package:tech_talk/core/data/responses/blog_info_response.dart';
import 'package:tech_talk/core/data/responses/blog_search_response.dart';
import 'package:tech_talk/core/data/responses/blogs_response.dart';
import 'package:tech_talk/core/data/responses/commun_response.dart';
import 'package:tech_talk/core/data/responses/create_comment_post.dart';
import 'package:tech_talk/core/data/responses/create_post_response.dart';
import 'package:tech_talk/core/data/responses/is_like_response.dart';
import 'package:tech_talk/core/data/responses/like_comment_response.dart';
import 'package:tech_talk/core/data/responses/otp_resend_response.dart';
import 'package:tech_talk/core/data/responses/post_comments_response.dart';
import 'package:tech_talk/core/data/responses/posts_response.dart';
import 'package:tech_talk/core/data/responses/posts_search_response.dart';
import 'package:tech_talk/core/data/responses/profile_response.dart';
import 'package:tech_talk/core/data/responses/register_response.dart';
import 'package:tech_talk/core/data/responses/remove_saved_response.dart';
import 'package:tech_talk/core/data/responses/save_post_blog_response.dart';
import 'package:tech_talk/core/data/responses/saved_item_response.dart';
import 'package:tech_talk/core/data/responses/sign_in_response.dart';
import 'package:tech_talk/core/data/responses/sign_out_response.dart';
import 'package:tech_talk/core/data/responses/tags_response.dart';
import 'package:tech_talk/core/data/responses/user_seach_response.dart';
import 'package:tech_talk/core/enum/request_type.dart';
import 'package:tech_talk/core/utils/network_util.dart';

class AuthRepository {
  //* authentication methods

  Future<Either<String, RegisterResponse>> signUp({
    required String name,
    required String email,
    required String username,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: '/api/register',
        body: {
          "name": name,
          "email": email,
          "username": username,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return Right(RegisterResponse.fromJson(communResponse.data ?? {}));
        } else {
          print(communResponse.message);
          print(communResponse.data);
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, SignInResponse>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: '/api/login',
        body: {"email": email, "password": password},
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return Right(SignInResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, SignOutResponse>> signOut({
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: '/api/logout',
        body: {"scope": "all", "all_devices": true},
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return Right(SignOutResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, VerifyOtpModel>> otpSign({
    required String email,
    required String code,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: '/api/otp/verify',
        body: {"email": email, "code": code},
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return Right(VerifyOtpModel.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, OtpResendResponse>> otpResend({
    required String email,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: '/api/otp/resend',
        body: {"email": email},
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return Right(OtpResendResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, PostsResponse>> forgetPassword({
    required String email,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: '/api/forgot-password',
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: {"email": email},
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);

        if (communResponse.getstatuscode) {
          return Right(PostsResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  //* Post methods

  Future<Either<String, PostsResponse>> getPosts({
    required int page,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: '/api/posts/recommended',

        params: {"page": page.toString(), "per_page": "10"},

        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);

        if (communResponse.getstatuscode) {
          return Right(PostsResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  //* saved methods

  Future<Either<String, SavePostBlogResponse>> savePostOrBlog({
    required String type,
    required int id,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: '/api/saves',
        body: {"id": id, "type": type},
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return Right(
            SavePostBlogResponse.fromJson(communResponse.data ?? {}),
          );
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, RemoveSavedResponse>> deleteSaved({
    required String type,
    required int id,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.DELETE,
        route: '/api/saves',
        body: {"id": id, "type": type},
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        print(value);
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return Right(RemoveSavedResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      print(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, IsLikeResponse>> likePost({
    required int id,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: '/api/posts/$id/toggle-like',
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        print(value);
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return Right(IsLikeResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      print(e.toString());
      return Left(e.toString());
    }
  }

  //* commets post methods

  Future<Either<String, PostCommentsResponse>> getPostComments({
    required int id,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: '/api/posts/$id/comments',
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);

        if (communResponse.getstatuscode) {
          return Right(
            PostCommentsResponse.fromJson(communResponse.data ?? {}),
          );
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, LikeCommentResponse>> likeComment({
    required int id,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: '/api/comments/$id/like',
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        print(value);
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return Right(LikeCommentResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      print(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, LikeCommentResponse>> dislikeComment({
    required int id,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: '/api/comments/$id/dislike',
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        print(value);
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return Right(LikeCommentResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      print(e.toString());
      return Left(e.toString());
    }
  }
  //* blogs methods

  Future<Either<String, BlogsResponse>> getBlogs({
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: '/api/blogs',
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);

        if (communResponse.getstatuscode) {
          return Right(BlogsResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, BlogInfoResponse>> getInfoBlog({
    required String token,
    required int id,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: '/api/blogs/$id',
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);

        if (communResponse.getstatuscode) {
          return Right(BlogInfoResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, IsLikeResponse>> likeBlog({
    required int id,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: '/api/blogs/$id/toggle-like',
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        print(value);
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return Right(IsLikeResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      print(e.toString());
      return Left(e.toString());
    }
  }

  
  Future<Either<String, ChildCommentsResponse>> getChildreenComments({
  required int id,
  required int page,
  required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: '/api/comments/$id/children',
        params: {"page": page.toString()},
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);

        if (communResponse.getstatuscode) {
          return Right(ChildCommentsResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }


    Future<Either<String, CreateCommentPostResponse>> createCommentPost({
    required String body,
    required int postId,
    required String token,
    required String code,
    required String codeLanguage,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: '/api/comments',
        body: { "body": body, "post_id": postId, "code": code, "code_language": codeLanguage},
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        print(value);
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return Right(CreateCommentPostResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      print(e.toString());
      return Left(e.toString());
    }
  }

  //* search methods */

  Future<Either<String, dynamic>> getSearch({
    required String query,
    required String tab,
    required int page,
    List<int> tags = const [],
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: '/api/search',

        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },

        body: {"query": query, "tab": tab, "tags": tags, "page": page},
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);

        if (communResponse.getstatuscode) {
          if (tab == "posts") {
            return Right(
              PostsSearchResponse.fromJson(communResponse.data ?? {}),
            );
          }
          if (tab == "blogs") {
            return Right(
              BlogsSearchResponse.fromJson(communResponse.data ?? {}),
            );
          }
          if (tab == "users") {
            return Right(
              UsersSearchresponse.fromJson(communResponse.data ?? {}),
            );
          }

          return Left("Unknown tab");
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ProfileResponse>> getInfoProfile({
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: '/api/show-me',
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);

        if (communResponse.getstatuscode) {
          return Right(ProfileResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, SavedItemsResponse>> getListsaved({
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: '/api/saved',
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        params: {"type": "all"},
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);

        if (communResponse.getstatuscode) {
          return Right(SavedItemsResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, TagsResponse>> getTags({required String token}) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: '/api/tags',
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        params: {"type": "all"},
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);

        if (communResponse.getstatuscode) {
          return Right(TagsResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, CreatePostResponse>> CreatePost({
    required Map<String, String> fields,
    required Map<String, String> files,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendMultipartRequest(
        type: RequestType.POST,
        route: '/api/posts',
        fields: fields,
        files: files,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);

        if (communResponse.getstatuscode) {
          return Right(CreatePostResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, PostsResponse>> getMyPosts({
    required String userName,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: '/api/users/$userName/posts',
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);

        if (communResponse.getstatuscode) {
          return Right(PostsResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
