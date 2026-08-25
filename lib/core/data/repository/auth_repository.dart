import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:tech_talk/core/data/models/notification_model.dart';
import 'package:tech_talk/core/data/responses/Activity_History_Response.dart';
import 'package:tech_talk/core/data/responses/childrem_comment_response.dart';
import 'package:tech_talk/core/data/responses/Verify_Otp_response.dart';
import 'package:tech_talk/core/data/responses/blog_info_response.dart';
import 'package:tech_talk/core/data/responses/blog_search_response.dart';
import 'package:tech_talk/core/data/responses/blogs_response.dart';
import 'package:tech_talk/core/data/responses/comment_info_response.dart';
import 'package:tech_talk/core/data/responses/commun_response.dart';
import 'package:tech_talk/core/data/responses/compiler_response.dart';
import 'package:tech_talk/core/data/responses/create_blog_response.dart';
import 'package:tech_talk/core/data/responses/create_comment_post.dart';
import 'package:tech_talk/core/data/responses/create_post_response.dart';
import 'package:tech_talk/core/data/responses/follow_response.dart';
import 'package:tech_talk/core/data/responses/highlight_comment_response.dart';
import 'package:tech_talk/core/data/responses/is_like_response.dart';
import 'package:tech_talk/core/data/responses/like_comment_response.dart';
import 'package:tech_talk/core/data/responses/list_road_maps_response.dart';
import 'package:tech_talk/core/data/responses/otp_resend_response.dart';
import 'package:tech_talk/core/data/responses/post_comments_response.dart';
import 'package:tech_talk/core/data/responses/post_info_response.dart';
import 'package:tech_talk/core/data/responses/posts_response.dart';
import 'package:tech_talk/core/data/responses/posts_search_response.dart';
import 'package:tech_talk/core/data/responses/profile_response.dart';
import 'package:tech_talk/core/data/responses/public_user_response.dart';
import 'package:tech_talk/core/data/responses/register_response.dart';
import 'package:tech_talk/core/data/responses/remove_saved_response.dart';
import 'package:tech_talk/core/data/responses/road_map_details_response.dart';
import 'package:tech_talk/core/data/responses/save_post_blog_response.dart';
import 'package:tech_talk/core/data/responses/saved_item_response.dart';
import 'package:tech_talk/core/data/responses/settings_response.dart';
import 'package:tech_talk/core/data/responses/sign_in_response.dart';
import 'package:tech_talk/core/data/responses/sign_out_response.dart';
import 'package:tech_talk/core/data/responses/suggestions_folowed_response.dart';
import 'package:tech_talk/core/data/responses/tags_response.dart';
import 'package:tech_talk/core/data/responses/update_name_response.dart';
import 'package:tech_talk/core/data/responses/update_post_response.dart';
import 'package:tech_talk/core/data/responses/user_blog_response.dart';
import 'package:tech_talk/core/data/responses/user_seach_response.dart';
import 'package:tech_talk/core/data/responses/username_update_response.dart';
import 'package:tech_talk/core/data/responses/view_response.dart';
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

  Future<Either<String, IsLikeResponse>> DeletePost({
    required int id,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.DELETE,
        route: '/api/posts/$id',
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

  Future<Either<String, IsLikeResponse>> DeleteComment({
    required int id,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.DELETE,
        route: '/api/comments/$id',
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

  Future<Either<String, PostInfoResponse>> getInfoPost({
    required String token,
    required int id,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: '/api/posts/$id',
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);

        if (communResponse.getstatuscode) {
          return Right(PostInfoResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, CommentInfoResponse>> getInfoComment({
    required String token,
    required int id,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: '/api/comments/$id',
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);

        if (communResponse.getstatuscode) {
          return Right(CommentInfoResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, CreateBlogResponse>> CreateBlog({
    required Map<String, String> fields,
    required Map<String, String> files,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendMultipartRequest(
        type: RequestType.POST,
        route: '/api/blogs',
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
          return Right(CreateBlogResponse.fromJson(communResponse.data ?? {}));
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
          return Right(
            ChildCommentsResponse.fromJson(communResponse.data ?? {}),
          );
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
    int? parentId,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: '/api/comments',
        body: {
          "body": body,
          "post_id": postId,
          "code": code,
          "code_language": codeLanguage,
          "parent_id": parentId,
        },
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
          return Right(
            CreateCommentPostResponse.fromJson(communResponse.data ?? {}),
          );
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

  Future<Either<String, dynamic>> getMyPosts({
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

  Future<Either<String, ListRoadMapsResponse>> getListRoadMaps({
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: '/api/roadmaps',
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);

        if (communResponse.getstatuscode) {
          return Right(
            ListRoadMapsResponse.fromJson(communResponse.data ?? {}),
          );
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, RoadMapDetailsResponse>> getInfoRoadMaps({
    required String token,
    required int roadMapId,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: '/api/roadmaps/$roadMapId',
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);

        if (communResponse.getstatuscode) {
          return Right(
            RoadMapDetailsResponse.fromJson(communResponse.data ?? {}),
          );
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ViewResponse>> viewed({
    required String token,
    required String type,
    required int blogId,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: '/api/views',
        body: {"type": type, "id": blogId},
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        final CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);

        if (communResponse.getstatuscode) {
          return Right(
            ViewResponse(
              status: 'success',
              message: communResponse.message,
              data: ViewRecordData.fromJson(communResponse.data ?? {}),
            ),
          );
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

  Future<Either<String, SuggestionsFolowedResponse>> suggestionFolowed({
    required String token,
    required String letters,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: '/api/suggestions',
        body: {"q": letters},
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
            SuggestionsFolowedResponse.fromJson(communResponse.data ?? {}),
          );
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, HighlightCommentResponse>> highlightComment({
    required String token,
    required String commentId,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: '/api/comments/$commentId/highlight',
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);

        if (communResponse.getstatuscode) {
          return Right(
            HighlightCommentResponse.fromJson(communResponse.data ?? {}),
          );
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, FollowResponse>> follow({
    required String token,
    required int userId,
    required bool isDel,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: isDel ? RequestType.DELETE : RequestType.POST,
        route: '/api/users/$userId/follow',
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);

        if (communResponse.getstatuscode) {
          return Right(FollowResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ActivityHistoryResponse>> getMyActivity({
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: '/api/activity',
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);

        if (communResponse.getstatuscode) {
          return Right(
            ActivityHistoryResponse.fromJson(communResponse.data ?? {}),
          );
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, publicUserResponse>> getUserProfile({
    required String token,
    required String userName,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: '/api/users/$userName/profile',
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);

        if (communResponse.getstatuscode) {
          return Right(publicUserResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, CompileCodeResponse>> compilerCode({
    required String language,
    required String token,
    required String code,
    required String input,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: '/api/compile',
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: {"language": language, "code": code, "input": input},
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return Right(CompileCodeResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      print(e.toString());
      return Left(e.toString());
    }
  }

  Future<Either<String, CreateBlogResponse>> editHeaderBlog({
    required Map<String, String> fields,
    required Map<String, String> files,
    required String token,
    required int blogId,
  }) async {
    try {
      return NetworkUtil.sendMultipartRequest(
        type: RequestType.POST,
        route: '/api/updateblog/$blogId',
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
          return Right(CreateBlogResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, CreateBlogResponse>> deleteBlog({
    required int idBlog,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.DELETE,
        route: '/api/blogs/$idBlog',
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return Right(CreateBlogResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Section>> createSection({
    required int idBlog,
    required Map<String, String> fields,
    required Map<String, String> files,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendMultipartRequest(
        type: RequestType.POST,
        route: '/api/blogs/$idBlog/sections',
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
          return Right(Section.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, CreateBlogResponse>> deleteSectionBlog({
    required int idSection,
    required int idBlog,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.DELETE,
        route: '/api/blogs/$idBlog/sections/$idSection',
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return Right(CreateBlogResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Section>> updateSection({
    required int idSection,
    required int idBlog,
    required Map<String, String> fields,
    required Map<String, String> files,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendMultipartRequest(
        type: RequestType.PUT,
        route: '/api/blogs/$idBlog/sections/$idSection',
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
          return Right(Section.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ProfileResponse>> editInfoProfile({
    required Map<String, String> fields,
    required Map<String, String> files,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendMultipartRequest(
        type: RequestType.POST,
        route: '/api/profile',
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
          return Right(ProfileResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, SettingsResponse>> getSettings({
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: '/api/settings',
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return Right(SettingsResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, SettingsResponse>> patchSettings({
    required String token,
    required Map<String, dynamic> patch,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.PATCH,
        route: '/api/settings',
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: patch,
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return Right(SettingsResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(value['message'] ?? 'Something went wrong');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UpdatePostResponse>> addPostPhoto({
    required int idPost,
    required String photoPath,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendMultipartRequest(
        type: RequestType.POST,
        route: '/api/posts/$idPost/photos',
        fields: const {},
        files: {'photo': photoPath},
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return Right(UpdatePostResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UpdatePostResponse>> deletePostPhoto({
    required int idPost,
    required String photo,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.DELETE,
        route: '/api/posts/$idPost/photos/$photo',
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return Right(UpdatePostResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UpdatePostResponse>> updatePostContent({
    required int idPost,
    required Map<String, dynamic> body,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.PUT,
        route: '/api/posts/$idPost/content',
        body: body,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return Right(UpdatePostResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, NotificationsListResponse>> getNotifications({
    required String token,
    int page = 1,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: '/api/notifications',
        params: {'page': page.toString()},
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          // ملاحظة: List notifications عندها pagination بمستوى الـ JSON
          // الجذري (مش جوّا data) - عدّل حسب شكل CommunResponse الفعلي
          // عندك لو بيقص هالحقل.
          return Right(
            NotificationsListResponse.fromJson(value['response'] ?? value),
          );
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, int>> getUnreadNotificationsCount({
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: '/api/notifications/unread-count',
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return Right(communResponse.data?['unread_count'] ?? 0);
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> markNotificationAsRead({
    required String notificationId,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.PATCH,
        route: '/api/notifications/$notificationId/read',
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return const Right(true);
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> markAllNotificationsAsRead({
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.PATCH,
        route: '/api/notifications/read-all',
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return const Right(true);
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UpdateNameResponse>> changeName({
    required String name,
    required String password,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: '/api/change-name',
        body: {'name': name, 'password': password},
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return Right(UpdateNameResponse.fromJson(communResponse.data ?? {}));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UsernameUpdateResponse>> updateUsername({
    required String username,
    required String password,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: '/api/updateusername',
        body: {'username': username, 'password': password},
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
            UsernameUpdateResponse.fromJson(communResponse.data ?? {}),
          );
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> updateEmail({
    required String email,
    required String password,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: '/api/updateemail',
        body: {'email': email, 'password': password},
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return const Right(true);
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, FollowResponse>> followUser({
    required String username,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: '/api/users/$username/follow',
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return Right(FollowResponse.fromJson(value['response'] ?? value));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, FollowResponse>> unfollowUser({
    required String username,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.DELETE,
        route: '/api/users/$username/follow',
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return Right(FollowResponse.fromJson(value['response'] ?? value));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> blockUser({
    required String username,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: '/api/users/$username/block',
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return const Right(true);
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> unblockUser({
    required String username,
    required String token,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.DELETE,
        route: '/api/users/$username/block',
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return const Right(true);
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UserBlogsResponse>> getUserBlogs({
    required String token,
    required String userName,
    int page = 1,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: '/api/users/$userName/blogs',
        params: {'page': page.toString()},
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((value) {
        CommunResponse<Map<String, dynamic>> communResponse =
            CommunResponse.fromjson(value);
        if (communResponse.getstatuscode) {
          return Right(UserBlogsResponse.fromJson(value['response'] ?? value));
        } else {
          return Left(communResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Uint8List> generateUmlImage({
    required String token,
    required String description,
  }) async {
    return await NetworkUtil.sendImageRequest(
      route: '/api/generate-uml',
      body: {"description": description},
      headers: {
        "Accept": "image/png",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }
}
