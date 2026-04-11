// // data.dart
// import 'package:workscout/data/model/job_model.dart';

// // import 'model.dart'; // استيراد الموديل

// // هنا نقوم بتخزين البيانات كما لو أنها جائت من الـ API
// List<Job> companiesData = [
//   Job(
//     companyName: 'Invision',
//     jobTitle: 'UI Designer',
//     location: 'Jakarta, Indonesia',
//     jobType: 'Remote',
//     contractType: 'Contract',
//     experienceLevel: 'Junior',
//     postedDate: '3 days ago',
//   ),
//   Job(
//     companyName: 'Telegram',
//     jobTitle: 'Digital Marketing',
//     location: 'Jakarta, Indonesia',
//     jobType: 'Remote',
//     contractType: 'Contract',
//     experienceLevel: 'Junior',
//     postedDate: '3 days ago',
//   ),
// ];

// List<Job> recommendationJobs = [
//   Job(
//     companyName: 'Netflix',
//     jobTitle: 'UI Designer',
//     location: 'Jakarta, Indonesia',
//     jobType: 'Remote',
//     contractType: 'Contract',
//     experienceLevel: 'Junior',
//     postedDate: '3 days ago',
//   ),
//   Job(
//     companyName: 'Autodesk',
//     jobTitle: 'Human Resources',
//     location: 'Jakarta, Indonesia',
//     jobType: 'Remote',
//     contractType: 'Contract',
//     experienceLevel: 'Junior',
//     postedDate: '3 days ago',
//   ),
// ];








// import 'package:workscout/data/model/job_model.dart';



// List<Job> allJobs = [
//   Job(
//     companyName: 'Netflix',
//     jobTitle: 'UI designer',
//     location: 'Jakarta, Indonesia - Onsite',
//     jobType: 'Fulltime',
//     contractType: 'Contract',
//     experienceLevel: 'Entry level',
//     postedDate: 'Updated 20 days ago',
//     salary: '\$ 12.000',
//     companyLogo: 'https://logo.clearbit.com/netflix.com',
//     skills: ['UI Design', 'Teamwork', 'UX Design', 'Adaptability', 'Critical Thinking', 'Analytical Skills'],
//     description: 'Netflix is seeking a talented UI Designer to join our design team...',
//     responsibilities: [
//       'Design user interfaces that are visually appealing and user-friendly.',
//       'Collaborate with cross-functional teams to define and implement innovative solutions.',
//       'Create wireframes, storyboards, user flows, process flows and site maps.'
//     ],
//     requirements: [
//       'Proven UI design experience with a strong portfolio.',
//       'Proficiency in design and prototyping tools like Figma, Sketch, etc.'
//     ],
//     benefits: [
//       'Competitive salary and benefits package.',
//       'Health, dental, and vision insurance.',
//       'Unlimited vacation policy.'
//     ],
//     officeAddress: 'Los Gatos, California, United States',
//     category: 'Design'
//   ),

//   //second job
//    Job(
//     companyName: 'Netflix',
//     jobTitle: 'Flutter Developer',
//     location: 'Jakarta, Indonesia - Onsite',
//     jobType: 'Fulltime',
//     contractType: 'Contract',
//     experienceLevel: 'Entry level',
//     postedDate: 'Updated 20 days ago',
//     salary: '\$ 12.000',
//     companyLogo: 'https://logo.clearbit.com/netflix.com',
//     skills: ['UI Design', 'Teamwork', 'UX Design', 'Adaptability', 'Critical Thinking', 'Analytical Skills'],
//     description: 'Netflix is seeking a talented UI Designer to join our design team...',
//     responsibilities: [
//       'Design user interfaces that are visually appealing and user-friendly.',
//       'Collaborate with cross-functional teams to define and implement innovative solutions.',
//       'Create wireframes, storyboards, user flows, process flows and site maps.'
//     ],
//     requirements: [
//       'Proven UI design experience with a strong portfolio.',
//       'Proficiency in design and prototyping tools like Figma, Sketch, etc.'
//     ],
//     benefits: [
//       'Competitive salary and benefits package.',
//       'Health, dental, and vision insurance.',
//       'Unlimited vacation policy.'
//     ],
//     officeAddress: 'Los Gatos, California, United States',
//     category: 'Marketing'
//   ),
//   // يمكنك إضافة المزيد من الوظائف هنا بنفس النمط
// ];
// data.dart
import 'package:workscout/data/model/job_model.dart';


// 1. المستخدم الحالي (ليكون البروفايل ديناميكياً)
// UserProfile currentUser = UserProfile(
//   name: "Nabilla",
//   position: "UI/UX Designer",
//   location: "Indonesia",
//   profilePic: "https://via.placeholder.com/150",
//   experiences: [
//     Experience(
//       title: "UI/UX Designer",
//       company: "Netflix",
//       date: "Dec 23 - Feb 24",
//       logo: "https://logo.clearbit.com/netflix.com",
//     ),
//     Experience(
//       title: "Junior UX Designer",
//       company: "Qiwi",
//       date: "Aug 22 - Dec 23",
//       logo: "https://logo.clearbit.com/qiwi.com",
//     ),
//   ],
//   skills: ["Figma", "Photoshop", "User Research"],
//   languages: ["English", "Mandarin", "Indonesia"],
//   savedJobsIds: [], // ستمتلئ بـ IDs الوظائف عند الضغط على Bookmark
// );
// 1. المستخدم الحالي (ليكون البروفايل ديناميكياً)

UserProfile currentUser = UserProfile(
  name: "hussam",
  position: "UI/UX Designer",
  location: "Indonesia",
  profilePic: "https://via.placeholder.com/150",
  experiences: [
    Experience(
      title: "UI/UX Designer",
      company: "Netflix",
      date: "Dec 23 - Feb 24",
      logo: "https://logo.clearbit.com/netflix.com",
    ),
    Experience(
      title: "Junior UX Designer",
      company: "Qiwi",
      date: "Aug 22 - Dec 23",
      logo: "https://logo.clearbit.com/qiwi.com",
    ),
  ],
  skills: ["Figma", "Photoshop", "User Research"],
  languages: ["English", "Mandarin", "Indonesia"],
  savedJobsIds: [], 
  education: [], // أضف هذا السطر هنا لحل المشكلة الثانية (يمكنك تركه فارغاً حالياً)
);

// 2. قائمة الوظائف الشاملة (المصدر الوحيد للبيانات في التطبيق)
List<Job> allJobs = [
  Job(
    id: "job_001",
    companyName: "Invision",
    jobTitle: "UI designer",
    location: "Jakarta, Indonesia - Onsite",
    jobType: "Remote",
    contractType: "Contract",
    experienceLevel: "Junior",
    postedDate: "3 days ago",
    salary: "\$ 12.000",
    companyLogo: "https://logo.clearbit.com/invisionapp.com",
    category: "Design",
    description: "Invision is seeking a talented UI Designer to join our team...",
    skills: ["UI Design", "Figma", "Interaction Design"],
    responsibilities: ["Create wireframes", "Collaborate with developers"],
    requirements: ["2+ years experience", "Portfolio required"],
    benefits: ["Remote work", "Health insurance"],
    officeAddress: "New York, USA",
  ),
  Job(
    id: "job_002",
    companyName: "Netflix",
    jobTitle: "Senior UI Designer",
    location: "Jakarta, Indonesia",
    jobType: "Fulltime",
    contractType: "Contract",
    experienceLevel: "Senior",
    postedDate: "2 days ago",
    salary: "\$ 15.000",
    companyLogo: "https://logo.clearbit.com/netflix.com",
    category: "Design",
    description: "Join Netflix's design team to create world-class experiences...",
    skills: ["UX Design", "Leadership", "Teamwork"],
    responsibilities: ["Lead design projects", "Mentor junior designers"],
    requirements: ["5+ years experience", "Strong UI/UX skills"],
    benefits: ["Competitive salary", "Free Netflix subscription"],
    officeAddress: "California, USA",
  ),
  Job(
    id: "job_003",
    companyName: "Telegram",
    jobTitle: "Digital Marketing",
    location: "Jakarta, Indonesia",
    jobType: "Remote",
    contractType: "Contract",
    experienceLevel: "Junior",
    postedDate: "1 day ago",
    salary: "\$ 8.000",
    companyLogo: "https://logo.clearbit.com/telegram.org",
    category: "Marketing",
    description: "We are looking for a creative marketing specialist...",
    skills: ["SEO", "Social Media", "Content Strategy"],
    responsibilities: ["Manage social campaigns", "Analyze traffic"],
    requirements: ["1+ year experience", "Marketing degree"],
    benefits: ["Flexible hours", "Remote work"],
    officeAddress: "Dubai, UAE",
  ),
];

// 3. قائمة طلبات التوظيف (ستستخدم في صفحة Tracking)
// تبدأ فارغة، وعندما يضغط المستخدم على Apply Now في التطبيق، سنضيف الطلب هنا
List<JobApplication> myApplications = [];