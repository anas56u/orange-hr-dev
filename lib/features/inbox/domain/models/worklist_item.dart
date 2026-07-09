enum WorklistItemType {
  leaveApproval,
  cardRequest,
  objectiveApproved,
  leaveRequest,
}

class WorklistItem {
  final WorklistItemType type;

  final String? senderName;
  final String? senderImageUrl;

  final String message;

  final String timeAgo;

  const WorklistItem({
    required this.type,
    required this.message,
    required this.timeAgo,
    this.senderName,
    this.senderImageUrl,
  });
}

const List<WorklistItem> mockWorklist = [
  WorklistItem(
    type: WorklistItemType.leaveApproval,
    message: 'Nicola Fanous approved your leave of absence',
    timeAgo: '2d',
  ),
  WorklistItem(
    type: WorklistItemType.cardRequest,
    message: 'Your request to issue a new card has been successfully submitted',
    timeAgo: '2d',
  ),
  WorklistItem(
    type: WorklistItemType.objectiveApproved,
    message: 'Your objectives have been approved',
    timeAgo: '2d',
  ),
  WorklistItem(
    type: WorklistItemType.leaveRequest,
    senderName: 'Bilal Alhamza',
    senderImageUrl:
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=256',
    message: 'Submitted a leave request',
    timeAgo: '2d',
  ),
  WorklistItem(
    type: WorklistItemType.leaveApproval,
    message: 'Nicola Fanous approved your leave of absence',
    timeAgo: '2d',
  ),
  WorklistItem(
    type: WorklistItemType.cardRequest,
    message: 'Your request to issue a new card has been successfully submitted',
    timeAgo: '2d',
  ),
  WorklistItem(
    type: WorklistItemType.objectiveApproved,
    message: 'Your objectives have been approved',
    timeAgo: '2d',
  ),
  WorklistItem(
    type: WorklistItemType.leaveRequest,
    senderName: 'Philippe Mansour',
    senderImageUrl:
        'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=256',
    message: 'Shared a story',
    timeAgo: '3d',
  ),
  WorklistItem(
    type: WorklistItemType.leaveApproval,
    message: 'Ahmad Khalil approved your overtime request',
    timeAgo: '4d',
  ),
  WorklistItem(
    type: WorklistItemType.objectiveApproved,
    message: 'Your training certificate has been approved',
    timeAgo: '5d',
  ),
];