//
//  ATLUIOutgoingMessageCollectionViewCell.m
//  Atlas
//
//  Created by Kevin Coleman on 8/31/14.
//  Copyright (c) 2014 Layer, Inc. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "ATLOutgoingMessageCollectionViewCell.h"

@interface ATLOutgoingMessageCollectionViewCell ()

@property (nonatomic) NSLayoutConstraint *bubbleWithAvatarRightConstraint;
@property (nonatomic) NSLayoutConstraint *bubbleWithoutAvatarRightConstraint;

@end

@implementation ATLOutgoingMessageCollectionViewCell

NSString *const ATLOutgoingMessageCellIdentifier = @"ATLOutgoingMessageCellIdentifier";
static CGFloat const ATLAvatarImageRightPadding = -12.0f;
static CGFloat const ATLAvatarImageLeftPadding = -7.0f;

+ (void)initialize
{
    ATLOutgoingMessageCollectionViewCell *proxy = [self appearance];
    proxy.bubbleViewColor = ATLBlueColor();
    proxy.messageTextColor = [UIColor whiteColor];
    proxy.messageLinkTextColor = [UIColor whiteColor];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self lyr_outgoingCommonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self lyr_outgoingCommonInit];
    }
    return self;
}

- (void)lyr_outgoingCommonInit
{
    self.avatarImageView.hidden = YES;
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.bubbleView  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-ATLMessageCellHorizontalMargin]];
}

- (void)shouldDisplayAvatarItem:(BOOL)shouldDisplayAvatarItem
{
    NSArray *constraints = [self.contentView constraints];
    if (shouldDisplayAvatarItem) {
        if ([constraints containsObject:self.bubbleWithAvatarRightConstraint]) return;
        [self.contentView removeConstraint:self.bubbleWithoutAvatarRightConstraint];
        [self.contentView addConstraint:self.bubbleWithAvatarRightConstraint];
    } else {
        if ([constraints containsObject:self.bubbleWithoutAvatarRightConstraint]) return;
        [self.contentView removeConstraint:self.bubbleWithAvatarRightConstraint];
        [self.contentView addConstraint:self.bubbleWithoutAvatarRightConstraint];
    }
    [self setNeedsUpdateConstraints];
}

- (void)updateWithSender:(id<ATLParticipant>)sender
{
    if (sender) {
        self.avatarImageView.hidden = NO;
        self.avatarImageView.avatarItem = sender;
    } else {
        self.avatarImageView.hidden = YES;
    }
}

- (void)configureConstraintsForOutgoingMessage
{
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:ATLAvatarImageRightPadding]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    self.bubbleWithAvatarRightConstraint = [NSLayoutConstraint constraintWithItem:self.bubbleView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.avatarImageView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:ATLAvatarImageLeftPadding];
    [self.contentView addConstraint:self.bubbleWithAvatarRightConstraint];
    self.bubbleWithoutAvatarRightConstraint = [NSLayoutConstraint constraintWithItem:self.bubbleWithoutAvatarRightConstraint attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:ATLMessageCellHorizontalMargin];
}

@end
