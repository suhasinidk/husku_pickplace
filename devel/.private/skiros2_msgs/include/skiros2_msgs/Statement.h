// Generated by gencpp from file skiros2_msgs/Statement.msg
// DO NOT EDIT!


#ifndef SKIROS2_MSGS_MESSAGE_STATEMENT_H
#define SKIROS2_MSGS_MESSAGE_STATEMENT_H


#include <string>
#include <vector>
#include <memory>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <skiros2_msgs/Relation.h>

namespace skiros2_msgs
{
template <class ContainerAllocator>
struct Statement_
{
  typedef Statement_<ContainerAllocator> Type;

  Statement_()
    : relation()
    , value(false)  {
    }
  Statement_(const ContainerAllocator& _alloc)
    : relation(_alloc)
    , value(false)  {
  (void)_alloc;
    }



   typedef  ::skiros2_msgs::Relation_<ContainerAllocator>  _relation_type;
  _relation_type relation;

   typedef uint8_t _value_type;
  _value_type value;





  typedef boost::shared_ptr< ::skiros2_msgs::Statement_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::skiros2_msgs::Statement_<ContainerAllocator> const> ConstPtr;

}; // struct Statement_

typedef ::skiros2_msgs::Statement_<std::allocator<void> > Statement;

typedef boost::shared_ptr< ::skiros2_msgs::Statement > StatementPtr;
typedef boost::shared_ptr< ::skiros2_msgs::Statement const> StatementConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::skiros2_msgs::Statement_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::skiros2_msgs::Statement_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::skiros2_msgs::Statement_<ContainerAllocator1> & lhs, const ::skiros2_msgs::Statement_<ContainerAllocator2> & rhs)
{
  return lhs.relation == rhs.relation &&
    lhs.value == rhs.value;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::skiros2_msgs::Statement_<ContainerAllocator1> & lhs, const ::skiros2_msgs::Statement_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace skiros2_msgs

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::skiros2_msgs::Statement_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::skiros2_msgs::Statement_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::skiros2_msgs::Statement_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::skiros2_msgs::Statement_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::skiros2_msgs::Statement_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::skiros2_msgs::Statement_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::skiros2_msgs::Statement_<ContainerAllocator> >
{
  static const char* value()
  {
    return "052db037d902fbb67131a3c41b93b371";
  }

  static const char* value(const ::skiros2_msgs::Statement_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x052db037d902fbb6ULL;
  static const uint64_t static_value2 = 0x7131a3c41b93b371ULL;
};

template<class ContainerAllocator>
struct DataType< ::skiros2_msgs::Statement_<ContainerAllocator> >
{
  static const char* value()
  {
    return "skiros2_msgs/Statement";
  }

  static const char* value(const ::skiros2_msgs::Statement_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::skiros2_msgs::Statement_<ContainerAllocator> >
{
  static const char* value()
  {
    return "Relation relation\n"
"bool value\n"
"\n"
"================================================================================\n"
"MSG: skiros2_msgs/Relation\n"
"string subjectId\n"
"string predicate\n"
"string objectId\n"
;
  }

  static const char* value(const ::skiros2_msgs::Statement_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::skiros2_msgs::Statement_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.relation);
      stream.next(m.value);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct Statement_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::skiros2_msgs::Statement_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::skiros2_msgs::Statement_<ContainerAllocator>& v)
  {
    s << indent << "relation: ";
    s << std::endl;
    Printer< ::skiros2_msgs::Relation_<ContainerAllocator> >::stream(s, indent + "  ", v.relation);
    s << indent << "value: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.value);
  }
};

} // namespace message_operations
} // namespace ros

#endif // SKIROS2_MSGS_MESSAGE_STATEMENT_H
