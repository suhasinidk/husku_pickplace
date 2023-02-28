// Generated by gencpp from file skiros2_msgs/ResourceGetDescriptionsRequest.msg
// DO NOT EDIT!


#ifndef SKIROS2_MSGS_MESSAGE_RESOURCEGETDESCRIPTIONSREQUEST_H
#define SKIROS2_MSGS_MESSAGE_RESOURCEGETDESCRIPTIONSREQUEST_H


#include <string>
#include <vector>
#include <memory>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace skiros2_msgs
{
template <class ContainerAllocator>
struct ResourceGetDescriptionsRequest_
{
  typedef ResourceGetDescriptionsRequest_<ContainerAllocator> Type;

  ResourceGetDescriptionsRequest_()
    {
    }
  ResourceGetDescriptionsRequest_(const ContainerAllocator& _alloc)
    {
  (void)_alloc;
    }







  typedef boost::shared_ptr< ::skiros2_msgs::ResourceGetDescriptionsRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::skiros2_msgs::ResourceGetDescriptionsRequest_<ContainerAllocator> const> ConstPtr;

}; // struct ResourceGetDescriptionsRequest_

typedef ::skiros2_msgs::ResourceGetDescriptionsRequest_<std::allocator<void> > ResourceGetDescriptionsRequest;

typedef boost::shared_ptr< ::skiros2_msgs::ResourceGetDescriptionsRequest > ResourceGetDescriptionsRequestPtr;
typedef boost::shared_ptr< ::skiros2_msgs::ResourceGetDescriptionsRequest const> ResourceGetDescriptionsRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::skiros2_msgs::ResourceGetDescriptionsRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::skiros2_msgs::ResourceGetDescriptionsRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}


} // namespace skiros2_msgs

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::skiros2_msgs::ResourceGetDescriptionsRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::skiros2_msgs::ResourceGetDescriptionsRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::skiros2_msgs::ResourceGetDescriptionsRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::skiros2_msgs::ResourceGetDescriptionsRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::skiros2_msgs::ResourceGetDescriptionsRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::skiros2_msgs::ResourceGetDescriptionsRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::skiros2_msgs::ResourceGetDescriptionsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "d41d8cd98f00b204e9800998ecf8427e";
  }

  static const char* value(const ::skiros2_msgs::ResourceGetDescriptionsRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xd41d8cd98f00b204ULL;
  static const uint64_t static_value2 = 0xe9800998ecf8427eULL;
};

template<class ContainerAllocator>
struct DataType< ::skiros2_msgs::ResourceGetDescriptionsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "skiros2_msgs/ResourceGetDescriptionsRequest";
  }

  static const char* value(const ::skiros2_msgs::ResourceGetDescriptionsRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::skiros2_msgs::ResourceGetDescriptionsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "\n"
;
  }

  static const char* value(const ::skiros2_msgs::ResourceGetDescriptionsRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::skiros2_msgs::ResourceGetDescriptionsRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream&, T)
    {}

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct ResourceGetDescriptionsRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::skiros2_msgs::ResourceGetDescriptionsRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream&, const std::string&, const ::skiros2_msgs::ResourceGetDescriptionsRequest_<ContainerAllocator>&)
  {}
};

} // namespace message_operations
} // namespace ros

#endif // SKIROS2_MSGS_MESSAGE_RESOURCEGETDESCRIPTIONSREQUEST_H
