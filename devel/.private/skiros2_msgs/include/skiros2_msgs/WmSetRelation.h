// Generated by gencpp from file skiros2_msgs/WmSetRelation.msg
// DO NOT EDIT!


#ifndef SKIROS2_MSGS_MESSAGE_WMSETRELATION_H
#define SKIROS2_MSGS_MESSAGE_WMSETRELATION_H

#include <ros/service_traits.h>


#include <skiros2_msgs/WmSetRelationRequest.h>
#include <skiros2_msgs/WmSetRelationResponse.h>


namespace skiros2_msgs
{

struct WmSetRelation
{

typedef WmSetRelationRequest Request;
typedef WmSetRelationResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct WmSetRelation
} // namespace skiros2_msgs


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::skiros2_msgs::WmSetRelation > {
  static const char* value()
  {
    return "77bf924d023af391d9b60bf1607be75e";
  }

  static const char* value(const ::skiros2_msgs::WmSetRelation&) { return value(); }
};

template<>
struct DataType< ::skiros2_msgs::WmSetRelation > {
  static const char* value()
  {
    return "skiros2_msgs/WmSetRelation";
  }

  static const char* value(const ::skiros2_msgs::WmSetRelation&) { return value(); }
};


// service_traits::MD5Sum< ::skiros2_msgs::WmSetRelationRequest> should match
// service_traits::MD5Sum< ::skiros2_msgs::WmSetRelation >
template<>
struct MD5Sum< ::skiros2_msgs::WmSetRelationRequest>
{
  static const char* value()
  {
    return MD5Sum< ::skiros2_msgs::WmSetRelation >::value();
  }
  static const char* value(const ::skiros2_msgs::WmSetRelationRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::skiros2_msgs::WmSetRelationRequest> should match
// service_traits::DataType< ::skiros2_msgs::WmSetRelation >
template<>
struct DataType< ::skiros2_msgs::WmSetRelationRequest>
{
  static const char* value()
  {
    return DataType< ::skiros2_msgs::WmSetRelation >::value();
  }
  static const char* value(const ::skiros2_msgs::WmSetRelationRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::skiros2_msgs::WmSetRelationResponse> should match
// service_traits::MD5Sum< ::skiros2_msgs::WmSetRelation >
template<>
struct MD5Sum< ::skiros2_msgs::WmSetRelationResponse>
{
  static const char* value()
  {
    return MD5Sum< ::skiros2_msgs::WmSetRelation >::value();
  }
  static const char* value(const ::skiros2_msgs::WmSetRelationResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::skiros2_msgs::WmSetRelationResponse> should match
// service_traits::DataType< ::skiros2_msgs::WmSetRelation >
template<>
struct DataType< ::skiros2_msgs::WmSetRelationResponse>
{
  static const char* value()
  {
    return DataType< ::skiros2_msgs::WmSetRelation >::value();
  }
  static const char* value(const ::skiros2_msgs::WmSetRelationResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // SKIROS2_MSGS_MESSAGE_WMSETRELATION_H