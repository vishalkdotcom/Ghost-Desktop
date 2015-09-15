//
//  BlogSelectorViewController.m
//  Ghost
//
//  Created by Enric Enrich on 14/09/15.
//
//

#import "BlogSelectorViewController.h"
#import "BlogSelectorCellView.h"
#import "BlogSelectorRowView.h"

#import "AppDelegate.h"
#import "BlogViewModel.h"

@interface BlogSelectorViewController () <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic, strong) NSScrollView *tableScrollView;
@property (nonatomic, strong) NSTableView *tableView;
@property (nonatomic, strong) NSButton *addBlogButton;

@property (nonatomic, strong) NSMutableArray *blogs;

@property (nonatomic, assign) NSInteger selectedRow;

@end

@implementation BlogSelectorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // UI
    [self.view addSubview:self.tableScrollView];
    [self.view addSubview:self.addBlogButton];
    
    NSDictionary *views = @{@"tableScrollView": self.tableScrollView,
                            @"addBlogButton": self.addBlogButton};
    
    [self setUpConstraintsForViews:views];
    
    // Data
    self.blogs = [NSMutableArray new];
    
    [self fetchBlogs];
    [self.tableView reloadData];
    
    // Notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didAddBlog:) name:DidAddBlogNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRemoveBlog:) name:DidRemoveBlogNotification object:nil];
}

#pragma mark - NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.blogs.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    BlogViewModel *blog = self.blogs[row];
    
    BlogSelectorCellView *cellView = [BlogSelectorCellView new];
    cellView.imageView.image = [NSImage imageNamed:@"GhostIcon"];
    cellView.textField.stringValue = blog.name;
    
    return cellView;
}

- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row
{
    return [BlogSelectorRowView new];
}

#pragma mark - NSTableViewDelegate

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    return 75;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    // Change previous selected cell
    BlogSelectorCellView *previousCellView = [self.tableView viewAtColumn:0 row:self.selectedRow makeIfNecessary:YES];
    [previousCellView unselectCell];
    
    // Select new cell
    BlogSelectorCellView *currentCellView = [self.tableView viewAtColumn:0 row:self.tableView.selectedRow makeIfNecessary:YES];
    [currentCellView selectCell];
    
    self.selectedRow = self.tableView.selectedRow;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BlogSelectionDidChangeNotification object:self.blogs[self.selectedRow]];
}

#pragma mark - Actions

- (void)didAddBlog:(NSNotification *)notification
{
    [self fetchBlogs];
    [self.tableView reloadData];
}

- (void)didRemoveBlog:(NSNotification *)notification
{
    [self fetchBlogs];
    [self.tableView reloadData];
}

- (void)openAddButtonWindow:(id)sender
{
    [[Utils appDelegate].addBlogWindowController showWindow:nil];
}

#pragma mark - Public

- (BlogViewModel *)selectedBlog
{
    return [[BlogViewModel alloc] initWithBlogInfo:self.blogs[self.selectedRow]];
}

#pragma mark - Getters

- (NSScrollView *)tableScrollView
{
    if (!_tableScrollView) {
        _tableScrollView = [NSScrollView new];
        _tableScrollView.hasVerticalScroller = YES;
        _tableScrollView.verticalScrollElasticity = NSScrollElasticityNone;
        _tableScrollView.documentView = self.tableView;
        _tableScrollView.borderType = NSNoBorder;
        _tableScrollView.drawsBackground = NO;
        _tableScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _tableScrollView;
}

- (NSTableView *)tableView
{
    if (!_tableView) {
        NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:@"Column"];
        column.width = 73;
        column.editable = NO;
        
        _tableView = [NSTableView new];
        _tableView.headerView = nil;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.allowsEmptySelection = NO;
        _tableView.backgroundColor = [NSColor clearColor];
        [_tableView addTableColumn:column];
    }
    
    return _tableView;
}

- (NSButton *)addBlogButton
{
    if (!_addBlogButton) {
        _addBlogButton = [NSButton new];
        _addBlogButton.title = @"+";
        _addBlogButton.bezelStyle = NSRoundedBezelStyle;
        _addBlogButton.target = self;
        _addBlogButton.action = @selector(openAddButtonWindow:);
        _addBlogButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _addBlogButton;
}

#pragma mark - Constraints

- (void)setUpConstraintsForViews:(NSDictionary *)views
{
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableScrollView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[addBlogButton]-10-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-22-[tableScrollView]-10-[addBlogButton(55)]-10-|" options:0 metrics:nil views:views]];
}

#pragma mark - Data

- (void)fetchBlogs
{
    self.blogs = [NSMutableArray arrayWithArray:[Utils blogs]];
}

@end
