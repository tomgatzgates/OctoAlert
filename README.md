# Idea

The idea is to have a service that displays better github notifications. The key requirements are: 

1. See the comment along side the code context
1. Categorize notifications for better management
1. Easily unsubscribe from notification threads

# Rough process

**Signup**

- User creates an account with notifyme  
- Notifyme generates a unique email to add to github
- User adds email to Github
- Notifyme informs user to validate their email

**Parse notification**

Notification email arrives from Github, email is scraped for:

- Notification type
- Repository
- Comment
- Code diff
- Unsubscribe url

**Display notifications**

Notifications are grouped by:

- Me
    + Author
    + Assigned
    + Mentioned
- Repos
- Merged
- Issue or PR
- Read vs Unread

**UI** 
```
                [ Issues | PR ]     [Read | Unread | All ]  [ !Merged ]
Me             
- Author        Implement soft delete (153)               15:46 11/11/18 [Mute]
- Assigned      NotifyMe - Backend API                                 [Expand]
- Mentioned     This looks good to me, ready to Ship 🚢            
                
Repos           Update marketing homepage (154)           10:13 11/11/18 [Mute]
- Repo A        NotifyMe - Frontend                                    [Expand]
- Repo B        Have you considered adding a link to the marketing department
- Repo C        email?
    
                OAuth integration for Google              9:46 11/11/18 [Mute] 
```
